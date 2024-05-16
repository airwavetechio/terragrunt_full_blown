# Store

locals {
  secret_env_name = "${var.app_name}-store-secret-env"
  config_env_name = "${var.app_name}-store-env"
  pvc_name        = "${var.app_name}-pvc"
  svc_port        = 9000
}

resource "kubernetes_stateful_set" "store" {
  metadata {
    name      = var.app_name
    namespace = var.namespace
    labels = {
      app             = var.app_name
      airwave_version = var.airwave_version
    }
    annotations = {
      "reloader.stakater.com/auto" = "true"
    }
  }

  spec {
    service_name = var.app_name
    replicas     = 1

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app             = var.app_name
          airwave_version = var.airwave_version
        }
      }

      spec {
        image_pull_secrets {
          name = var.image_pull_secret_name
        }
        init_container {
          image_pull_policy = "Always"
          name              = "test"
          image             = var.container_image
          command           = ["/bin/sh", "-c", "--"]
          args              = [join(" ", ["mkdir -p", join(" ", [for b in var.buckets : "/data/${b}"])])]
          volume_mount {
            mount_path = "/data"
            name       = "store-volume"
          }
        }
        container {
          image_pull_policy = "Always"
          image             = var.container_image
          # command = [ "/bin/sh", "-c", "--" ]
          # args = [ "while true; do sleep 30; done;" ]
          name = var.app_name
          args = var.minio_command
          volume_mount {
            mount_path = "/data"
            name       = "store-volume"
          }
          resources {
            # limits = {
            #   cpu    = "0.6"
            #   memory = "512Mi"
            # }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          env_from {
            secret_ref {
              name = local.secret_env_name
            }
          }

          env_from {
            config_map_ref {
              name = local.config_env_name
            }
          }

          port {
            name           = "service"
            container_port = 9000
          }
        }
        volume {
          name = "store-volume"
          persistent_volume_claim {
            claim_name = local.pvc_name
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_service.store
  ]
}

resource "kubernetes_service" "store" {
  metadata {
    name      = var.app_name
    namespace = var.namespace
  }
  spec {
    selector = {
      app = var.app_name
    }
    session_affinity = "ClientIP"
    port {
      name        = "service"
      port        = local.svc_port
      target_port = "service"
    }
  }
}

resource "kubernetes_config_map" "store-env" {
  metadata {
    name      = local.config_env_name
    namespace = var.namespace
  }

  data = {
    MINIO_ACCESS_KEY      = var.access_key
    AWS_ACCESS_KEY_ID     = var.aws_access_key
    AZURE_STORAGE_ACCOUNT = var.azure_storage_account
  }
}

resource "kubernetes_secret" "store-secret-env" {
  metadata {
    name      = local.secret_env_name
    namespace = var.namespace
  }

  data = {
    MINIO_SECRET_KEY               = var.secret_key
    AWS_SECRET_KEY                 = var.aws_secret_key
    GOOGLE_APPLICATION_CREDENTIALS = var.google_application_credentials
    AZURE_STORAGE_KEY              = var.azure_storage_key
  }
}

resource "kubernetes_persistent_volume_claim" "store" {
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
