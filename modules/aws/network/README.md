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
| [aws_internet_gateway.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.internet_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_subnet.subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | Address CIDR for the network | `string` | `"10.0.0.0/16"` | no |
| <a name="input_name_postfix"></a> [name\_postfix](#input\_name\_postfix) | The name postfix that will be added to all resources | `string` | `"dev"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Aws availability zone network will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_id_all"></a> [subnet\_id\_all](#output\_subnet\_id\_all) | n/a |
| <a name="output_subnet_id_private_link_cidr"></a> [subnet\_id\_private\_link\_cidr](#output\_subnet\_id\_private\_link\_cidr) | n/a |
| <a name="output_subnet_id_private_link_id"></a> [subnet\_id\_private\_link\_id](#output\_subnet\_id\_private\_link\_id) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
