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
| [azurerm_linux_virtual_machine.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.postgres_data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_machine_data_disk_attachment.postgres_data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `map` | <pre>{<br>  "centos": "centos",<br>  "ubuntu": "ubuntu"<br>}</pre> | no |
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | Defines the allocation method for this IP address. Possible values are Static or Dynamic. | `string` | `"Static"` | no |
| <a name="input_allowed_ips_list"></a> [allowed\_ips\_list](#input\_allowed\_ips\_list) | List of IPs for the inbound firewall rule(s). | `list(any)` | `[]` | no |
| <a name="input_disk_caching"></a> [disk\_caching](#input\_disk\_caching) | The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite. | `string` | `"ReadWrite"` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `number` | `100` | no |
| <a name="input_image_offer"></a> [image\_offer](#input\_image\_offer) | Specifies the offer of the image used to create the virtual machines. | `map` | <pre>{<br>  "centos": "CentOS",<br>  "ubuntu": "UbuntuServer"<br>}</pre> | no |
| <a name="input_image_publisher"></a> [image\_publisher](#input\_image\_publisher) | Specifies the publisher of the image used to create the virtual machines. | `map` | <pre>{<br>  "centos": "OpenLogic",<br>  "ubuntu": "Canonical"<br>}</pre> | no |
| <a name="input_image_sku"></a> [image\_sku](#input\_image\_sku) | Specifies the SKU of the image used to create the virtual machines. | `map` | <pre>{<br>  "centos": "7.5",<br>  "ubuntu": "18.04-LTS"<br>}</pre> | no |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | Specifies the version of the image used to create the virtual machines. | `map` | <pre>{<br>  "centos": "latest",<br>  "ubuntu": "latest"<br>}</pre> | no |
| <a name="input_ip_version"></a> [ip\_version](#input\_ip\_version) | The IP Version to use, IPv6 or IPv4. | `string` | `"IPv4"` | no |
| <a name="input_location"></a> [location](#input\_location) | The regional location of your Azure environemnt | `string` | `"East US"` | no |
| <a name="input_operatingsystem"></a> [operatingsystem](#input\_operatingsystem) | The Operating System of the virtual machines. | `map` | <pre>{<br>  "centos": "latest",<br>  "ubuntu": "latest"<br>}</pre> | no |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | The allocation method used for the Private IP Address. Possible values are Dynamic and Static. | `string` | `"Dynamic"` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The Public Key which should be used for authentication, which needs to be at least 2048-bit and in ssh-rsa format. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The regional location of your Azure environemnt | `string` | `"dev"` | no |
| <a name="input_size"></a> [size](#input\_size) | The SKU which should be used for this Virtual Machine, such as Standard\_F2. | `string` | `"Standard_D8_v3"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. | `string` | `"Standard"` | no |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard\_LRS, StandardSSD\_LRS and Premium\_LRS. Changing this forces a new resource to be created. | `string` | `"Standard_LRS"` | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The name postfix that will be added to all resources | `string` | `"dev"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet ID of your Azure environment | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags on the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_postgres_instance_id"></a> [postgres\_instance\_id](#output\_postgres\_instance\_id) | n/a |
| <a name="output_postgres_instance_name"></a> [postgres\_instance\_name](#output\_postgres\_instance\_name) | n/a |
| <a name="output_postgres_private_ip_address"></a> [postgres\_private\_ip\_address](#output\_postgres\_private\_ip\_address) | n/a |
| <a name="output_postgres_public_ip_address"></a> [postgres\_public\_ip\_address](#output\_postgres\_public\_ip\_address) | n/a |
| <a name="output_server_info"></a> [server\_info](#output\_server\_info) | n/a |
