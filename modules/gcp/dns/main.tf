# For connectivity outside of Azure (i.e. VPN and Public)
resource "google_dns_record_set" "airwave" {
  count = var.isPiensoStack ? 1 : 0
  name  = "${var.subdomain}.${var.domain}."
  type  = "A"
  ttl   = var.ttl

  managed_zone = "airwave"
  project      = "airwave-stack-shared-admin"

  rrdatas = var.record_ip
}

resource "google_dns_record_set" "randomclient" {
  count = var.isPiensoStack ? 0 : 1
  name  = "${var.subdomain}.${var.domain}."
  type  = "A"
  ttl   = var.ttl

  managed_zone = "randomclient"
  project      = "airwave-general"

  rrdatas = var.record_ip
}
