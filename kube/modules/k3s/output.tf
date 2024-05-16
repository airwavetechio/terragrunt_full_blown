output "kube_config" {
    value = data.external.kubeconfig.result.kubeconf
    sensitive = true
}

output "node" {
    value = var.node
}

output "proxy_external_ips" {
    value = compact([var.node.host, var.node.internal_ip])
}