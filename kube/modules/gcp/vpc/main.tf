# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  project                 = var.project_id
  auto_create_subnetworks = "false"
}

# K8s subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
  depends_on = [
    google_compute_network.vpc
  ]
}

resource "google_compute_global_address" "load_balancer" {
  provider     = google-beta
  project      = var.project_id
  name         = "ingress-load-balancer"
  address_type = "EXTERNAL"
}



resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta
  project = var.project_id
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
  depends_on = [google_compute_network.vpc]
}

resource "google_service_networking_connection" "private_vpc_connection" {
  service                 = "servicenetworking.googleapis.com"
  network                 = google_compute_network.vpc.id
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
  depends_on = [
    google_compute_global_address.private_ip_address
  ]
}
