resource "kubernetes_ingress_v1" "this" {
  wait_for_load_balancer = true
  metadata {
    name      = var.eks_cluster_id
    namespace = var.ingress_namespace

    annotations = {
      "alb.ingress.kubernetes.io/scheme"                   = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"              = "ip"
      "alb.ingress.kubernetes.io/success-codes"            = "200,308"
      "alb.ingress.kubernetes.io/load-balancer-attributes" = "routing.http.xff_header_processing.mode=remove"
    }
  }

  spec {
    ingress_class_name = "alb"
    default_backend {
      service {
        name = "proxy"
        port {
          number = 80
        }
      }
    }
  }
}

resource "google_dns_record_set" "subdomain" {
  count = var.isPiensoStack ? 1 : 0
  name  = "${var.subdomain}.${var.domain}."
  type  = "CNAME"
  ttl   = 300

  managed_zone = "airwave"
  project      = "airwave-stack-shared-admin"

  rrdatas = [
    "${kubernetes_ingress_v1.this.status.0.load_balancer.0.ingress.0.hostname}."
  ]
}
