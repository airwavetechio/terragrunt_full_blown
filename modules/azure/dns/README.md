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
| [azurerm_private_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | The base domain for this zone | `string` | n/a | yes |
| <a name="input_isPiensoStack"></a> [isPiensoStack](#input\_isPiensoStack) | Determines the creation of a domain name for the stack | `bool` | `false` | no |
| <a name="input_record_ip"></a> [record\_ip](#input\_record\_ip) | A list of IPs associated with the record\_name | `list(string)` | <pre>[<br>  "10.0.180.17"<br>]</pre> | no |
| <a name="input_registration_enabled"></a> [registration\_enabled](#input\_registration\_enabled) | Auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled. | `bool` | `true` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Azure resource group name | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The subdomain or host name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags on the resources | `map(string)` | `{}` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | The DNS records TTL | `number` | `300` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | The ID of the Private DNS Zone Virtual Network Link. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_dns_zone_id"></a> [azurerm\_dns\_zone\_id](#output\_azurerm\_dns\_zone\_id) | zone id |
| <a name="output_dns_a_record_fqdn"></a> [dns\_a\_record\_fqdn](#output\_dns\_a\_record\_fqdn) | n/a |
| <a name="output_dns_a_record_id"></a> [dns\_a\_record\_id](#output\_dns\_a\_record\_id) | n/a |
