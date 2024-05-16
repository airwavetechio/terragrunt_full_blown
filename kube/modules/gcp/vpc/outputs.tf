output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "vpc_subnetwork" {
  value = google_compute_subnetwork.subnet.name
}

output "load_balancer_name" {
  value = google_compute_global_address.load_balancer.name
}

output "load_balancer_ip" {
  value = google_compute_global_address.load_balancer.address
}
output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "vpc_ip_cidr_range" {
  value = google_compute_subnetwork.subnet.ip_cidr_range
}
