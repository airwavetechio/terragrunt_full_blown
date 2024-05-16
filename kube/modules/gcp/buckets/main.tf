locals {
  buckets = toset(["core", "analysis", "ingest", "config", "backup"])
}

resource "random_id" "bucket" {
  byte_length = 4
}

resource "google_storage_bucket" "bucket" {
  for_each      = local.buckets
  project       = var.project_id
  name          = "${each.value}-${random_id.bucket.dec}"
  location      = var.region
  storage_class = "REGIONAL"
  force_destroy = true
  depends_on = [
    random_id.bucket
  ]
}

# Service account
resource "google_service_account" "service" {
  for_each     = local.buckets
  project      = var.project_id
  account_id   = "${google_storage_bucket.bucket[each.key].name}-service"
  display_name = google_storage_bucket.bucket[each.key].name
  depends_on = [
    google_storage_bucket.bucket
  ]
}

resource "google_service_account_key" "service_account_key" {
  service_account_id = "${google_storage_bucket.bucket["backup"].name}-service@${var.project_id}.iam.gserviceaccount.com"
  depends_on = [
    google_storage_bucket.bucket,
    google_service_account.service
  ]
}

# IAM role
resource "google_storage_bucket_iam_member" "services" {
  for_each = local.buckets
  bucket   = google_storage_bucket.bucket[each.key].name
  role     = "roles/storage.admin"
  member   = "serviceAccount:${google_service_account.service[each.key].email}"
  depends_on = [
    google_service_account.service
  ]
}

resource "google_project_iam_member" "database_admin_permissions" {
  role   = "roles/cloudsql.admin"
  member = "serviceAccount:${google_service_account.service["backup"].email}"
  project = var.project_id
  depends_on = [
    google_service_account.service
  ]
}

#Create the HMAC key for the associated service account 
resource "google_storage_hmac_key" "key" {
  project               = var.project_id
  for_each              = local.buckets
  service_account_email = google_service_account.service[each.key].email
  depends_on = [
    google_storage_bucket_iam_member.services
  ]
}
