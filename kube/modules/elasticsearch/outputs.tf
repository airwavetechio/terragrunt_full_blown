output "elasticsearch_service" {
  value = "${local.app_name}.${var.namespace}.svc.cluster.local"
}
