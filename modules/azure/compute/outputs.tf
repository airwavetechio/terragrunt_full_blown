output "docker_swarm_masters" {
  value = azurerm_public_ip.docker_swarm_master.*
}

output "docker_swarm_masters_private_ip_address" {
  value = azurerm_linux_virtual_machine.docker_swarm_master.*.private_ip_address
}

output "docker_swarm_masters_all" {
  value = azurerm_linux_virtual_machine.docker_swarm_master.*
}

output "docker_swarm_masters_network_interface_id" {
  value = azurerm_network_interface.docker_swarm_master.*.id
}

output "docker_swarm_workers" {
  value = azurerm_public_ip.docker_swarm_worker.*
}

output "docker_swarm_workers_all" {
  value = azurerm_linux_virtual_machine.docker_swarm_worker.*
}

output "docker_swarm_workers_network_interface_id" {
  value = azurerm_network_interface.docker_swarm_worker.*.id
}

output "docker_gpu_workers" {
  value = azurerm_public_ip.docker_gpu_worker.*
}

output "docker_gpu_workers_all" {
  value = azurerm_linux_virtual_machine.docker_gpu_worker.*
}

output "docker_gpu_workers_network_interface_id" {
  value = azurerm_network_interface.docker_gpu_worker.*.id
}