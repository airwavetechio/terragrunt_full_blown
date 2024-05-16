## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elb.loadbalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb) | resource |
| [aws_security_group.loadbalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_docker_swarm_master_ids"></a> [docker\_swarm\_master\_ids](#input\_docker\_swarm\_master\_ids) | The Network Interface IDs for Docker Swarm Masters | `list(string)` | n/a | yes |
| <a name="input_airwave_lb_sg"></a> [airwave\_lb\_sg](#input\_airwave\_lb\_sg) | Security group for the external loadbalancer | `list(map(any))` | <pre>[<br>  {<br>    "description": "http",<br>    "destination_port_range": "80",<br>    "protocol": "tcp",<br>    "source_address": "10.20.0.0/24",<br>    "source_port_range": "80"<br>  },<br>  {<br>    "description": "https",<br>    "destination_port_range": "443",<br>    "protocol": "tcp",<br>    "source_address": "10.20.0.0/24",<br>    "source_port_range": "443"<br>  },<br>  {<br>    "description": "https",<br>    "destination_port_range": "443",<br>    "protocol": "tcp",<br>    "source_address": "10.20.0.0/24",<br>    "source_port_range": "443"<br>  }<br>]</pre> | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The name postfix that will be added to all resources | `string` | `"dev"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs to attach to the ELB. | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id where compute machines will be provisioned | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | n/a |
| <a name="output_id"></a> [id](#output\_id) | The Load Balancer ID. |
