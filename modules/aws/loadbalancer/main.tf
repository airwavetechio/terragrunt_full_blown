resource "aws_elb" "loadbalancer" {
  name = "${var.subdomain}-loadbalancer"

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/health"
    interval            = 30
  }

  subnets   = var.subnet_ids
  instances = concat(var.docker_swarm_master_ids)

  security_groups = [
    aws_security_group.loadbalancer.id
  ]

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}


resource "aws_security_group" "loadbalancer" {
  name        = "${var.subdomain}-loadbalancer"
  description = "External loadbalancer communication"
  vpc_id      = var.vpc_id

  dynamic "egress" {
    for_each = var.airwave_lb_sg
    content {
      description = egress.value["description"]
      from_port   = egress.value["source_port_range"]
      to_port     = egress.value["destination_port_range"]
      protocol    = egress.value["protocol"]
      cidr_blocks = [egress.value["source_address"]]
    }
  }

  # Inbound internet access
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

