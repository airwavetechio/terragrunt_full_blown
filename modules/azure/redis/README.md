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
| [azurerm_redis_cache.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4. | `string` | `"4"` | no |
| <a name="input_enable_non_ssl_port"></a> [enable\_non\_ssl\_port](#input\_enable\_non\_ssl\_port) | Enable the non-SSL port (6379) - disabled by default. | `bool` | `false` | no |
| <a name="input_family"></a> [family](#input\_family) | The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium) | `string` | `"C"` | no |
| <a name="input_location"></a> [location](#input\_location) | The regional location of your Azure environemnt | `string` | `"East US"` | no |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The minimum TLS version. | `string` | `"1.2"` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | Redis version. Only major version needed. Valid values: 4, 6. | `number` | `6` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The regional location of your Azure environemnt | `string` | `"dev"` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of Redis to use. Possible values are Basic, Standard and Premium. | `string` | `"Basic"` | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The name postfix that will be added to all resources | `string` | `"dev"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags on the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The Hostname of the Redis Instance |
| <a name="output_id"></a> [id](#output\_id) | The Route ID. |
| <a name="output_port"></a> [port](#output\_port) | The Port of the Redis Instance |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The Primary Access Key for the Redis Instance |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string of the Redis Instance. |
| <a name="output_ssl_port"></a> [ssl\_port](#output\_ssl\_port) | The SSL Port of the Redis Instance |
