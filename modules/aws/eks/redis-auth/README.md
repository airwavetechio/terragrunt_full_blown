## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_cluster.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_subnet_group.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_security_group.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_airwave_redis_sg"></a> [airwave\_redis\_sg](#input\_airwave\_redis\_sg) | Security group for the redis swarm masters | `list(map(any))` | <pre>[<br>  {<br>    "description": "redis",<br>    "destination_port_range": "6379",<br>    "protocol": "Tcp",<br>    "source_address": "10.0.2.0/24",<br>    "source_port_range": "6379"<br>  }<br>]</pre> | no |
| <a name="input_redis_cache_subnet_ids"></a> [redis\_cache\_subnet\_ids](#input\_redis\_cache\_subnet\_ids) | A cache subnet group is a collection of subnets that you may want to designate for your cache clusters in a VPC | `list(string)` | n/a | yes |
| <a name="input_redis_param_group_name"></a> [redis\_param\_group\_name](#input\_redis\_param\_group\_name) | Parameter group name for redis | `string` | `"default.redis6.x"` | no |
| <a name="input_redis_port"></a> [redis\_port](#input\_redis\_port) | Port number which redis will listen for new connections | `number` | `6379` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | Redis version. Only major version needed. Valid values: 4, 6. | `string` | `"6.x"` | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The name postfix that will be added to all resources | `string` | `"dev"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id where compute machines will be provisioned | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The Hostname of the Redis Instance |
| <a name="output_port"></a> [port](#output\_port) | The Port of the Redis Instance |
