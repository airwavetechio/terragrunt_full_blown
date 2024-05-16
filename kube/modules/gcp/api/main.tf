resource "google_project_service" "compute_api" {
  project                    = var.project_id
  service                    = "compute.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
}

resource "google_project_service" "kubernetes_api" {
  project                    = var.project_id
  service                    = "container.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
  depends_on = [
    google_project_service.compute_api
  ]
}

resource "google_project_service" "redis_api" {
  project                    = var.project_id
  service                    = "redis.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
  depends_on = [
    google_project_service.compute_api
  ]
}

resource "google_project_service" "cloud_sql_admin" {
  project                    = var.project_id
  service                    = "sqladmin.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
  depends_on = [
    google_project_service.compute_api
  ]
}

resource "google_project_service" "service_networking_api" {
  project                    = var.project_id
  service                    = "servicenetworking.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
  depends_on = [
    google_project_service.compute_api
  ]
}
