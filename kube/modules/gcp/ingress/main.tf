locals {
  ingress = "${var.app_name}-ingress"
  frontend_config = "${var.app_name}-frontendconfig"
}

resource "google_compute_ssl_policy" "strict_ssl_policy" {
  name            = var.ssl_policy_name
  project         = var.gke_project_id
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}

resource "kubernetes_manifest" "ingress_frontend_config" {
  manifest = {
    apiVersion = "networking.gke.io/v1beta1"
    kind       = "FrontendConfig"
    metadata = {
      name      = local.frontend_config
      namespace = var.namespace
    }
    spec = {
      "sslPolicy" = var.ssl_policy_name
    }
  }

  depends_on = [ 
    google_compute_ssl_policy.strict_ssl_policy
  ]
}

resource "kubernetes_manifest" "ssl_cert" {
  computed_fields = ["metadata.labels", "metadata.annotations", "spec"]
  manifest = {
    apiVersion = "networking.gke.io/v1beta1"
    kind       = "ManagedCertificate"
    metadata = {
      name      = "ssl-cert"
      namespace = var.namespace
    }
    spec = {
      "domains" = [var.domain_name]
    }
  }
}

resource "kubernetes_ingress_v1" "proxy_ingress" {
  metadata {
    name      = local.ingress
    namespace = var.namespace
    annotations = {
      "kubernetes.io/ingress.class"                 = "gce"
      "kubernetes.io/ingress.global-static-ip-name" = "ingress-load-balancer"
      "networking.gke.io/managed-certificates"      = "ssl-cert"
      "networking.gke.io/v1beta1.FrontendConfig"    = local.frontend_config
    }
  }

  spec {
    default_backend {
      service {
        name = var.app_name
        port {
          number = 80
        }
      }
    }

    rule {
      http {
        path {
          backend {
            service {
              name = var.app_name
              port {
                number = 80
              }
            }
          }
          path = "/"
        }
      }
    }
  }
  depends_on = [
    kubernetes_manifest.ingress_frontend_config
  ]
}
