## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.private_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | Address CIDR for the network | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | DNS Servers for the network | `list(string)` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region to deploy resources to | `string` | `"East US"` | no |
| <a name="input_name_postfix"></a> [name\_postfix](#input\_name\_postfix) | The name postfix that will be added to all resources | `string` | `"dev"` | no |
| <a name="input_subnet_address_prefix_private_link"></a> [subnet\_address\_prefix\_private\_link](#input\_subnet\_address\_prefix\_private\_link) | A list of subnet address prefixes for the private link subnet | `list(string)` | <pre>[<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#input\_subnet\_address\_prefixes) | A list of subnet address prefixes | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags on the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | n/a |
| <a name="output_subnet_id_private_link_id"></a> [subnet\_id\_private\_link\_id](#output\_subnet\_id\_private\_link\_id) | n/a |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | n/a |
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | n/a |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | n/a |
