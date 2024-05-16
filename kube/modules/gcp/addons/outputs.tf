output "backup-api-token_secret" {
  value = kubernetes_secret.backup-api-token_secret.metadata[0]
}

output "gcs_secret" {
  value = kubernetes_secret.gcs_secret.metadata[0]
}
output "pvc_name" {
  value = var.ingest.pvc_name
}
