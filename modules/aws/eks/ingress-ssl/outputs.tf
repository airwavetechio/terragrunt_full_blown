output "status" {
    description = "Ingress IP"
    value       = kubernetes_ingress_v1.this.status
}
