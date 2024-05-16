resource "helm_release" "eck" {
  name = "eck"

  repository = "https://helm.elastic.co"
  chart      = "eck-operator"
  namespace  = var.namespace
  version    = "2.8.0"

  set {
    name  = "installCRDs"
    value = false
  }
}

resource "kubernetes_manifest" "elastic" {
  manifest = {
    apiVersion = "elasticsearch.k8s.elastic.co/v1"
    kind       = "Elasticsearch"
    metadata = {
      name      = "elasticsearch"
      namespace = var.namespace
    }
    spec = {
      version = var.eck_version
      auth = {
        fileRealm = [{
          secretName = "elastic-custom-user"
        }]
      }
      nodeSets = [
        {
          name  = "default"
          count = 1
          volumeClaimTemplates = [{
            metadata = {
              name = "elasticsearch-data"
            }
            spec = {
              accessModes = ["ReadWriteOnce"]
              resources = {
                requests = {
                  storage = var.eck_storage_size
                }
              }
            }
          }]

          podTemplate = {
            spec = {
              initContainers = [{
                name = "systctl"
                securityContext = {
                  privileged = true
                  runAsUser  = 0
                }
                command = ["sh", "-c", "sysctl -w vm.max_map_count=262144"]
              }]
            }
          }
        }
      ]
    }
  }
  field_manager {
    # force field manager conflicts to be overridden
    force_conflicts = true
  }
  depends_on = [
    helm_release.eck
  ]
}

resource "kubernetes_manifest" "kibana" {
  computed_fields = ["metadata.labels", "metadata.annotations", "spec.podTemplate"]
  manifest = {
    apiVersion = "kibana.k8s.elastic.co/v1"
    kind       = "Kibana"
    metadata = {
      name      = "kibana"
      namespace = var.namespace
    }
    spec = {
      version = var.eck_version
      elasticsearchRef = {
        name      = "elasticsearch"
        namespace = var.namespace
      }
      count = 1
      http = {
        tls = {
          selfSignedCertificate = {
            disabled = true
          }
        }
      }
      podTemplate = {
        spec = {
          containers = [{
            name = "kibana"
            env = [{
              name  = "SERVER_BASEPATH",
              value = "/logging"
            }]
            readinessProbe = {
              httpGet = {
                path   = "/app/home"
                port   = 5601
                scheme = "HTTP"
              }
            }
            resources = {
              requests = {
                memory = "2Gi"
              }
              limits = {
                memory = "4Gi"
              }
            }
          }]
        }
      }
      config = {
        "telemetry.optIn"                    = false
        "telemetry.allowChangingOptInStatus" = false
        "xpack.security.authc.providers" = {
          "anonymous.anonymous1" = {
            order = 0
            credentials = {
              username = "admin"
              password = random_password.elastic_custom_user_password.result
            }
          }
        }
        "xpack.fleet.agents.elasticsearch.hosts" = ["https://elasticsearch-es-http.${var.namespace}.svc:9200"]
        "xpack.fleet.agents.fleet_server.hosts"  = ["https://fleet-server-agent-http.${var.namespace}.svc:8220"]
        "xpack.fleet.packages" = [
          {
            name    = "system"
            version = "latest"
          },
          {
            name    = "elastic_agent"
            version = "latest"
          },
          {
            name    = "fleet_server"
            version = "latest"
          },
          {
            name    = "kubernetes"
            version = "latest"
          },
        ],
        "xpack.fleet.agentPolicies" = [
          {
            name                    = "Fleet server on eck policy"
            id                      = "eck-fleet-server"
            is_default_fleet_server = "true"
            namespace               = "default"
            monitoring_enabled      = ["logs", "metrics"]
            unenroll_timeout        = 900
            package_policies = [
              {
                name = "fleet_server-1"
                id   = "fleet_server-1"
                package = {
                  name = "fleet_server"
                }
              }
            ]
          },
          {
            name               = "Elastic Agent on ECK policy"
            id                 = "eck-agent"
            namespace          = "default"
            monitoring_enabled = ["logs", "metrics"]
            unenroll_timeout   = 900
            is_default         = true
            package_policies = [
              # {
              #   name = "system-1"
              #   id   = "system-1"
              #   package = {
              #     name = "system"
              #   }
              # },
              {
                name = "kubernetes-1"
                id   = "kubernetes-1"
                package = {
                  name = "kubernetes"
                }
              }
            ]
          }
        ]
      }
    }
  }
  field_manager {
    # force field manager conflicts to be overridden
    force_conflicts = true
  }
  depends_on = [
    helm_release.eck,
    kubernetes_manifest.elastic
  ]
}

resource "random_password" "elastic_custom_user_password" {
  length  = 16
  special = false
}

# This user will be used to authenticate in elastic by kibana
resource "kubernetes_secret" "elastic_custom_user" {
  metadata {
    name      = "elastic-custom-user"
    namespace = var.namespace
  }

  data = {
    username = "admin"
    password = random_password.elastic_custom_user_password.result
    "roles"  = "kibana_admin,ingest_admin,viewer,monitoring_user,editor,beats_admin,apm_system,superuser"
  }

  type = "kubernetes.io/basic-auth"
  depends_on = [
    helm_release.eck
  ]
}
