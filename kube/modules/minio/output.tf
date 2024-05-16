
output "minio_endpoint" {
  value = "http://${var.app_name}.${var.namespace}.svc.cluster.local:${local.svc_port}"
}