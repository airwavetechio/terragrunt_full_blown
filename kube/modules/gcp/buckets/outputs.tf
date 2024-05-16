output "storage_container_info" {
  sensitive = true
  value = {
    for k, v in google_storage_bucket.bucket :
    k => {
      id            = v.id
      name          = v.name
      access_key_id = google_storage_hmac_key.key[k].access_id
      access_key    = google_storage_hmac_key.key[k].secret
    }
  }
}

output "google_service_account_key" {
  sensitive = true
  value = google_service_account_key.service_account_key
}
