resource "kubernetes_manifest" "fleet" {
  computed_fields = ["metadata.labels", "metadata.annotations", "spec"]
  manifest = {
    apiVersion = "agent.k8s.elastic.co/v1alpha1"
    kind       = "Agent"
    metadata = {
      name      = "fleet-server"
      namespace = var.namespace
    }
    spec = {
      version = var.eck_version
      kibanaRef = {
        name = "kibana",
      }
      elasticsearchRefs = [{
        name = "elasticsearch"
      }]
      mode               = "fleet"
      fleetServerEnabled = true
      deployment = {
        replicas = 1
        podTemplate = {
          spec = {
            serviceAccountName           = "fleet-server"
            automountServiceAccountToken = true
            securityContext = {
              runAsUser = 0
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.eck,
    kubernetes_manifest.elastic,
    kubernetes_manifest.kibana
  ]
}

resource "kubernetes_manifest" "elastic_agent" {
  computed_fields = ["metadata.labels", "metadata.annotations", "spec"]
  manifest = {
    apiVersion = "agent.k8s.elastic.co/v1alpha1"
    kind       = "Agent"
    metadata = {
      name      = "elastic-agent"
      namespace = var.namespace
    }
    spec = {
      version = var.eck_version
      kibanaRef = {
        name = "kibana",
      }
      fleetServerRef = {
        name = "fleet-server"
      }
      mode = "fleet"
      daemonSet = {
        podTemplate = {
          spec = {
            serviceAccountName           = "elastic-agent"
            hostNetwork =  true
            dnsPolicy = "ClusterFirstWithHostNet"
            automountServiceAccountToken = true
            tolerations = [
              {
                key      = ""
                operator = "Exists"
                effect   = ""
              }
            ]
            containers = [{
              name = "agent"
                securityContexts = {
                runAsUser = 0
              }
              volumeMounts = [
              {
                mountPath: "/var/log/containers"
                name: "varlogcontainers"
              },
              {
                mountPath: "/var/log/pods"
                name: "varlogpods"
              }]
            }]
            volumes = [
                {
                  name = "varlogcontainers"
                  hostPath ={
                    path = "/var/log/containers"
                  }
                },
                {
                  name = "varlogpods"
                  hostPath ={
                    path = "/var/log/pods"
                  }
                }
              ]
            securityContext = {
              runAsUser = 0
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_cluster_role" "fleet-server" {
  metadata {
    name = "fleet-server"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "pods", "nodes"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["coordination.k8s.io"]
    resources  = ["leases"]
    verbs      = ["get", "create", "update"]
  }
}


resource "kubernetes_service_account" "fleet-server" {
  metadata {
    namespace = var.namespace
    name      = "fleet-server"
  }
}

resource "kubernetes_cluster_role_binding" "fleet-server" {
  metadata {
    name = "fleet-server"
  }
  role_ref {
    kind      = "ClusterRole"
    name      = "fleet-server"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "fleet-server"
    namespace = var.namespace
  }
}


resource "kubernetes_cluster_role" "elastic-agent" {
  metadata {
    name = "elastic-agent"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "pods", "nodes", "events", "services", "configmaps", "persistentvolumeclaims", "persistentvolumes"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    non_resource_urls = ["/metrics"]
    verbs             = ["get"]
  }

  rule {
    api_groups = ["storage.k8s.io"]
    resources  = ["*"]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }

  rule { 
    api_groups = ["extensions"]
    resources = ["replicasets"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = [
      "apps",
    ]
    resources = [
      "statefulsets",
      "deployments",
      "replicasets",
      "daemonsets",
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }

  rule {
    api_groups = ["coordination.k8s.io"]
    resources  = ["leases"]
    verbs      = ["get", "create", "update"]
  }

   rule {
    api_groups = [""]
    resources  = ["nodes/stats"]
    verbs      = ["get"]
  }
  rule {
    api_groups = ["batch"]
    resources  = ["jobs", "cronjobs"]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }
}

resource "kubernetes_service_account" "elastic-agent" {
  metadata {
    namespace = var.namespace
    name      = "elastic-agent"
  }
}

resource "kubernetes_cluster_role_binding" "elastic-agent" {
  metadata {
    name = "elastic-agent"
  }
  role_ref {
    kind      = "ClusterRole"
    name      = "elastic-agent"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "elastic-agent"
    namespace = var.namespace
  }
}
