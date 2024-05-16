## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticsearch_domain.es](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain) | resource |
| [aws_elasticsearch_domain_policy.es_vpc_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain_policy) | resource |
| [aws_security_group.elasticsearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_iam_policy_document.es_vpc_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_elastic_sg"></a> [elastic\_sg](#input\_elastic\_sg) | Security group for the elastic | `list(map(any))` | <pre>[<br>  {<br>    "description": "https",<br>    "destination_port_range": "443",<br>    "protocol": "Tcp",<br>    "source_address": "10.20.0.0/24",<br>    "source_port_range": "443"<br>  }<br>]</pre> | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of elastic nodes | `number` | `1` | no |
| <a name="input_storage_size_gb"></a> [storage\_size\_gb](#input\_storage\_size\_gb) | The Size of volume. | `number` | `500` | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The name postfix that will be added to all resources | `string` | `"dev"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet ids which should access elastic | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags on the resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id where compute machines will be provisioned | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elasticsearch_instance"></a> [elasticsearch\_instance](#output\_elasticsearch\_instance) | n/a |
| <a name="output_elasticsearch_public_ip_address"></a> [elasticsearch\_public\_ip\_address](#output\_elasticsearch\_public\_ip\_address) | n/a |
