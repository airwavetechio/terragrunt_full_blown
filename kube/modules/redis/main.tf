# Redis

locals {
  redis_port = 6379
}
resource "kubernetes_deployment" "redis" {
  metadata {
    name      = var.app_name
    namespace = var.namespace
    labels = {
      app = var.app_name
    }
    annotations = {
      "reloader.stakater.com/auto" = "true"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        image_pull_secrets {
          name = var.image_pull_secret_name
        }
        container {
          image_pull_policy = "Always"
          image   = var.container_image
          name    = var.app_name
          command = ["redis-server", "--requirepass", var.redis_password]
          resources {
            # limits = {
            #   cpu    = "0.5"
            #   memory = "512Mi"
            # }
            requests = {
              cpu    = "250m"
              memory = "512Mi"
            }
          }
          liveness_probe {
            exec {
              command = ["redis-cli", "-a", var.redis_password, "--raw", "incr", "ping" ]
            }
            initial_delay_seconds = 30
            period_seconds        = 60
            timeout_seconds       = 35
            failure_threshold     = 3
            success_threshold     = 1
          }
          port {
            container_port = local.redis_port
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "redis" {
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
      port        = local.redis_port
      target_port = local.redis_port
    }
  }
}
