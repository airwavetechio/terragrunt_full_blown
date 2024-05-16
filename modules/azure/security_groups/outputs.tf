output "docker_swarm_master_network_security_group_id" {
  value = azurerm_network_security_group.docker_swarm_master.id
}

output "docker_swarm_worker_network_security_group_id" {
  value = azurerm_network_security_group.docker_swarm_worker.id
}

output "docker_gpu_worker_network_security_group_id" {
  value = azurerm_network_security_group.docker_gpu_worker.id
}