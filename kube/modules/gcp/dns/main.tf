resource "google_dns_record_set" "subdomain" {
  name = "${var.subdomain}."
  type = "A"
  ttl  = var.ttl

  managed_zone = var.dns_zone
  project      = var.project
  rrdatas      = var.records
}