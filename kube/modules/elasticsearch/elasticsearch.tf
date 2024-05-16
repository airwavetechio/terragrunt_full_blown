# elasticsearch

resource "kubernetes_stateful_set" "elasticsearch" {
  metadata {
    name      = local.app_name
    namespace = var.namespace
    labels = {
      app             = local.app_name
      airwave_version = var.airwave_version
    }
    annotations = {
      "reloader.stakater.com/auto" = "true"
    }
  }

  spec {
    service_name = local.app_name
    replicas     = 1 # Every node

    selector {
      match_labels = {
        app = local.app_name
      }
    }

    template {
      metadata {
        labels = {
          app             = local.app_name
          airwave_version = var.airwave_version
        }
      }

      spec {
        init_container {
          name              = "node-script"
          image             = var.container_image
          image_pull_policy = "Always"
          security_context {
            privileged = true
          }
          command = ["/bin/sh", "-c", "--"]
          # Need to be dynamic
          args = ["sysctl -w vm.max_map_count=262144 && (echo y | bin/elasticsearch-keystore add-file gcs.client.default.credentials_file /usr/share/elasticsearch/key/gcs-sa.json) || true && chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data || true"]
          volume_mount {
            mount_path = "/data"
            name       = "shared-data"
          }
          dynamic "volume_mount" {
            for_each = try(coalesce(var.custom["ingest_elasticsearch"].gcs_sa, []), [])
            content {
              mount_path = volume_mount.value.mount_path
              name       = volume_mount.value.name
            }
          }
          dynamic "volume_mount" {
            for_each = try(coalesce(var.custom["ingest_elasticsearch"].elasticsearch_config, []), [])
            content {
              mount_path = volume_mount.value.mount_path
              name       = volume_mount.value.name
            }
          }
          volume_mount {
            mount_path = "/usr/share/elasticsearch/data/"
            name       = "data-volume"
          }
        }
        volume {
          name = "shared-data"
          empty_dir {}
        }
        restart_policy = "Always"
        container {
          image_pull_policy = "Always"
          image             = var.container_image
          name              = local.app_name
          resources {
            limits = {
              cpu    = "0.5"
              memory = "10Gi"
            }
            requests = {
              cpu    = "250m"
              memory = "10Gi"
            }
          }
          env_from {
            config_map_ref {
              name = local.env
            }
          }
          # liveness_probe {
          #   http_get {
          #     path = "/"
          #     port = 4180

          #     http_header {
          #       name  = "X-Custom-Header"
          #       value = "Awesome"
          #     }
          #   }

          #   initial_delay_seconds = 3
          #   period_seconds        = 3
          # }
          volume_mount {
            mount_path = "/usr/share/elasticsearch/data/"
            name       = "data-volume"
          }
          dynamic "volume_mount" {
            for_each = try(coalesce(var.custom["ingest_elasticsearch"].gcs_sa, []), [])
            content {
              mount_path = volume_mount.value.mount_path
              name       = volume_mount.value.name
            }
          }
          dynamic "volume_mount" {
            for_each = try(coalesce(var.custom["ingest_elasticsearch"].elasticsearch_config, []), [])
            content {
              mount_path = "${volume_mount.value.mount_path}${volume_mount.value.sub_path}"
              sub_path   = volume_mount.value.sub_path
              name       = volume_mount.value.name
            }
          }
        }
        dynamic "volume" {
          for_each = try(coalesce(var.custom["ingest_elasticsearch"].gcs_sa, []), [])
          content {
            name = volume.value.name
            secret {
              secret_name = "gcs-secret"
            }
          }
        }

        dynamic "volume" {
          for_each = try(coalesce(var.custom["ingest_elasticsearch"].elasticsearch_config, []), [])
          content {
            name = volume.value.name
            persistent_volume_claim {
              claim_name = volume.value.claim_name
            }
          }
        }

        volume {
          name = "data-volume"
          persistent_volume_claim {
            claim_name = local.pvc_name
          }
        }
        image_pull_secrets {
          name = var.image_pull_secret_name
        }
      }
    }
  }
  depends_on = [
    kubernetes_config_map.elasticsearch_env,
    # kubernetes_persistent_volume_claim.elasticsearch
  ]
}

resource "kubernetes_service" "elasticsearch" {
  metadata {
    name      = local.app_name
    namespace = var.namespace
  }
  spec {
    selector = {
      app = local.app_name
    }
    port {
      port        = 9200
      target_port = 9200
    }
    session_affinity = "ClientIP"
  }
}

resource "kubernetes_config_map" "elasticsearch_env" {
  metadata {
    name      = local.env
    namespace = var.namespace
  }

  data = {
    ES_SETTING_CLUSTER_NAME                       = "ingest-cluster"
    ES_SETTING_NETWORK_HOST                       = "0.0.0.0"
    ES_SETTING_DISCOVERY_ZEN_MINIMUM_MASTER_NODES = 1
    ES_SETTING_HTTP_CORES_ENABLED                 = true
    ES_SETTING_HTTP_CORES_ALLOW-ORIGIN            = "'*'"
    ES_SETTING_HTTP_PORT                          = 9200
    ES_SETTING_DISCOVERY_TYPE                     = "single-node"
    ES_SETTING_BOOTSTRAP_MEMORY_LOCK              = true
    ES_JAVA_OPTS                                  = "-Xms8g -Xmx8g -Des.allow_insecure_settings=true"
  }
}

resource "kubernetes_persistent_volume_claim" "elasticsearch" {
  metadata {
    name      = local.pvc_name
    namespace = var.namespace
  }
  spec {
    storage_class_name = var.storage_class
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = var.pvc_size
      }
    }
    volume_name = var.pv_name
  }
}
