
output "docker_swarm_masters_private_ip_address" {
  value = aws_instance.docker_swarm_master.*.private_ip
}

output "docker_swarm_masters_all" {
  value = aws_instance.docker_swarm_master.*
}

output "docker_swarm_workers_all" {
  value = aws_instance.docker_swarm_worker.*
}

output "docker_gpu_workers_all" {
  value = aws_instance.docker_gpu_worker.*
}