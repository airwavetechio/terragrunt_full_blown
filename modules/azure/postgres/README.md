## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azurerm_postgresql_configuration"></a> [azurerm\_postgresql\_configuration](#module\_azurerm\_postgresql\_configuration) | ./modules/configurations | n/a |
| <a name="module_azurerm_postgresql_firewall_rule"></a> [azurerm\_postgresql\_firewall\_rule](#module\_azurerm\_postgresql\_firewall\_rule) | ./modules/firewall_rules | n/a |
| <a name="module_azurerm_postgresql_virtual_network_rule"></a> [azurerm\_postgresql\_virtual\_network\_rule](#module\_azurerm\_postgresql\_virtual\_network\_rule) | ./modules/virtual_network_rules | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_server.server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created. | `string` | `"postgres"` | no |
| <a name="input_administrator_password_list"></a> [administrator\_password\_list](#input\_administrator\_password\_list) | The password map associated with the administrator\_login for the PostgreSQL Server. | `map` | n/a | yes |
| <a name="input_auto_grow_enabled"></a> [auto\_grow\_enabled](#input\_auto\_grow\_enabled) | Storage auto-grow prevents your server from running out of storage and becoming read-only. Defaults to true | `string` | `true` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | Backup retention days for the server, supported values are between 7 and 35 days. | `number` | `7` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | n/a | `list` | `[]` | no |
| <a name="input_firewall_rule_prefix"></a> [firewall\_rule\_prefix](#input\_firewall\_rule\_prefix) | Specifies prefix for firewall rule names. | `string` | `"firewall-"` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | List of IPs for the inbound firewall rule(s).  This can not be used if public\_network\_access\_enabled = false. | `list` | `[]` | no |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | A suffix to the database name (optional) | `string` | `""` | no |
| <a name="input_postgresql_configurations"></a> [postgresql\_configurations](#input\_postgresql\_configurations) | A map with PostgreSQL configurations to enable. | `map(string)` | `{}` | no |
| <a name="input_private_link_subnet"></a> [private\_link\_subnet](#input\_private\_link\_subnet) | The subnet to place the private links into | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this server. Possible values are Enabled and Disabled. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_server_version"></a> [server\_version](#input\_server\_version) | Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, and 10.0. Changing this forces a new resource to be created. | `string` | `"11"` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B\_Gen4\_1, GP\_Gen5\_8). | `string` | `"GP_Gen5_8"` | no |
| <a name="input_ssl_enforcement_enabled"></a> [ssl\_enforcement\_enabled](#input\_ssl\_enforcement\_enabled) | Specifies if SSL should be enforced on connections. Possible values are Enabled and Disabled. | `bool` | `true` | no |
| <a name="input_ssl_minimal_tls_version_enforced"></a> [ssl\_minimal\_tls\_version\_enforced](#input\_ssl\_minimal\_tls\_version\_enforced) | Minimum SSL version allowed | `string` | `"TLS1_2"` | no |
| <a name="input_storage_mb"></a> [storage\_mb](#input\_storage\_mb) | Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs. | `number` | `102400` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to set on every taggable resources. Empty by default. | `map(string)` | `{}` | no |
| <a name="input_vnet_rule_name_prefix"></a> [vnet\_rule\_name\_prefix](#input\_vnet\_rule\_name\_prefix) | Specifies prefix for vnet rule names. | `string` | `"postgresql-vnet-rule-"` | no |
| <a name="input_vnet_rules"></a> [vnet\_rules](#input\_vnet\_rules) | The list of maps, describing vnet rules. Valud map items: name, subnet\_id. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_postgresql_server_all"></a> [azurerm\_postgresql\_server\_all](#output\_azurerm\_postgresql\_server\_all) | n/a |
| <a name="output_server_fqdn"></a> [server\_fqdn](#output\_server\_fqdn) | n/a |
| <a name="output_server_info"></a> [server\_info](#output\_server\_info) | n/a |
| <a name="output_server_name"></a> [server\_name](#output\_server\_name) | n/a |
