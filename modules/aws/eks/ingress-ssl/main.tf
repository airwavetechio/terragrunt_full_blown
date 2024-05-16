# create SSL in AWS
resource "aws_acm_certificate" "ssl" {
  domain_name       = "${var.subdomain}.${var.domain}"
  validation_method = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# create the DNS entry
resource "google_dns_record_set" "ssl" {
  for_each = {
    for dvo in aws_acm_certificate.ssl.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      rrdatas = [dvo.resource_record_value]
    }
  }

  name         = each.value.name
  managed_zone = "airwave"
  project      = "airwave-stack-shared-admin"

  type    = each.value.type
  ttl     = 60
  rrdatas = each.value.rrdatas
}


# Validate the cert
resource "aws_acm_certificate_validation" "ssl" {
  certificate_arn = aws_acm_certificate.ssl.arn

  # DNS validation requires creating a DNS record in Google Cloud DNS
  # to prove domain ownership
  for_each = {
    for dvo in aws_acm_certificate.ssl.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      rrdatas = [dvo.resource_record_value]
    }
  }
  validation_record_fqdns = [each.value.name]
  depends_on = [
    google_dns_record_set.ssl
  ]
}

# Create ingress and ALB
resource "kubernetes_ingress_v1" "this" {
  wait_for_load_balancer = true
  metadata {
    name      = "ingress"
    namespace = var.ingress_namespace

    annotations = {
      "kubernetes.io/ingress.class"             = "alb"
      "alb.ingress.kubernetes.io/listen-ports"  = "[{\"HTTPS\":443},{\"HTTP\":80}]"
      "alb.ingress.kubernetes.io/scheme"        = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"   = "ip"
      "alb.ingress.kubernetes.io/success-codes" = "200,308"
      //"alb.ingress.kubernetes.io/load-balancer-attributes" = "routing.http.xff_header_processing.mode=remove"
      "alb.ingress.kubernetes.io/certificate-arn" = aws_acm_certificate.ssl.arn
      //"alb.ingress.kubernetes.io/actions.ssl-redirect" = "{\"Type\": \"redirect\", \"RedirectConfig\": { \"Protocol\": \"HTTPS\", \"Port\": \"443\", \"StatusCode\": \"HTTP_301\"}}"
      //"alb.ingress.kubernetes.io/ssl-redirect" = "443"
      "alb.ingress.kubernetes.io/ip-address-type" = "ipv4"

    }
  }

  spec {
    tls {
      hosts = ["${var.subdomain}.${var.domain}"]
    }
    default_backend {
      service {
        name = "proxy"
        port {
          number = 80
        }
      }
    }
    # rule {
    #   http {
    #     path {
    #       backend {
    #         service {
    #           name = "ssl-redirect"
    #           port {
    #             name = "http"
    #           }
    #         }
    #       }

    #       path = "/*"
    #     }

    #     path {
    #       backend {
    #         service {
    #           name = "proxy"
    #           port {
    #             number = 80
    #           }
    #         }
    #       }

    #       path = "/*"
    #     }
    #   }
    # }
  }
}

# Set up domain name CNAME t0 ALB
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
  depends_on = [
    kubernetes_ingress_v1.this
  ]
}
