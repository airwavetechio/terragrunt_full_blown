terraform {
  required_version = ">= 1.0.9"
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = [var.aws_ami_owner[var.operatingsystem]]

  filter {
    name   = "name"
    values = [var.aws_ami[var.operatingsystem]]
  }
}

resource "aws_key_pair" "master" {
  key_name   = "${var.subdomain}-master-ssh-key"
  public_key = var.docker_swarm_master_public_key
}

resource "aws_security_group" "docker_swarm_master" {
  name   = "sg_docker_swarm_master_${var.subdomain}"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.docker_swarm_master_sg
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["source_port_range"]
      to_port     = ingress.value["destination_port_range"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = [ingress.value["source_address"]]
    }
  }

  dynamic "egress" {
    for_each = var.docker_swarm_master_sg_egress
    content {
      description = egress.value["description"]
      from_port   = egress.value["source_port_range"]
      to_port     = egress.value["destination_port_range"]
      protocol    = egress.value["protocol"]
      cidr_blocks = [egress.value["source_address"]]
    }
  }
}


resource "aws_instance" "docker_swarm_master" {
  count                       = var.is_suspended ? 0 : var.swarm_manager_count[var.airwave_size]
  instance_type               = var.swarm_manager_flavor[var.airwave_size]
  ami                         = data.aws_ami.ami.id
  key_name                    = aws_key_pair.master.id
  subnet_id                   = var.subnet_id
  availability_zone           = var.zone
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.docker_swarm_master_disk_size_gb
  }

  vpc_security_group_ids = [
    aws_security_group.docker_swarm_master.id
  ]

  tags = {
    Name = "docker-swarm-master-${var.subdomain}-${count.index}"
  }
}

resource "aws_key_pair" "worker" {
  key_name   = "${var.subdomain}-worker-ssh-key"
  public_key = var.docker_swarm_worker_public_key
}

resource "aws_security_group" "docker_swarm_worker" {
  name   = "sg_docker_swarm_worker_${var.subdomain}"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.docker_swarm_worker_sg
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["source_port_range"]
      to_port     = ingress.value["destination_port_range"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = [ingress.value["source_address"]]
    }
  }

  dynamic "egress" {
    for_each = var.docker_swarm_worker_sg_egress
    content {
      description = egress.value["description"]
      from_port   = egress.value["source_port_range"]
      to_port     = egress.value["destination_port_range"]
      protocol    = egress.value["protocol"]
      cidr_blocks = [egress.value["source_address"]]
    }
  }
}

resource "aws_instance" "docker_swarm_worker" {
  count                       = var.is_suspended ? 0 : var.swarm_worker_count[var.airwave_size]
  instance_type               = var.swarm_worker_flavor[var.airwave_size]
  ami                         = data.aws_ami.ami.id
  key_name                    = aws_key_pair.worker.id
  subnet_id                   = var.subnet_id
  availability_zone           = var.zone
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.docker_swarm_worker_disk_size_gb
  }

  vpc_security_group_ids = [
    aws_security_group.docker_swarm_worker.id
  ]

  tags = {
    Name = "docker-swarm-worker-${var.subdomain}-${count.index}"
  }
}

resource "aws_instance" "docker_gpu_worker" {
  count                       = var.is_suspended ? 0 : var.gpu_shapes[var.gpu_shape].pool_training_units + var.gpu_shapes[var.gpu_shape].pool_production_units
  instance_type               = var.swarm_gpu_worker_flavor[var.airwave_size]
  ami                         = data.aws_ami.ami.id
  key_name                    = aws_key_pair.worker.id
  subnet_id                   = var.subnet_id
  availability_zone           = var.zone
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.docker_gpu_worker_disk_size_gb
  }

  vpc_security_group_ids = [
    aws_security_group.docker_swarm_worker.id
  ]

  tags = {
    Name = "docker-swarm-gpu-worker-${var.subdomain}-${count.index}"
  }
}
