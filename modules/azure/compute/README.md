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
| [azurerm_linux_virtual_machine.docker_gpu_worker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_linux_virtual_machine.docker_swarm_master](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_linux_virtual_machine.docker_swarm_worker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.docker_gpu_worker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.docker_swarm_master](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.docker_swarm_worker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.docker_gpu_worker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.docker_swarm_master](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.docker_swarm_worker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.docker_gpu_worker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.docker_swarm_master](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.docker_swarm_worker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.docker_gpu_worker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.docker_swarm_master](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.docker_swarm_worker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | Defines the allocation method for this IP address. Possible values are Static or Dynamic. | `string` | `"Static"` | no |
| <a name="input_docker_gpu_worker_admin_username"></a> [docker\_gpu\_worker\_admin\_username](#input\_docker\_gpu\_worker\_admin\_username) | The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `map` | <pre>{<br>  "centos": "centos",<br>  "ubuntu": "ubuntu"<br>}</pre> | no |
| <a name="input_docker_gpu_worker_disk_caching"></a> [docker\_gpu\_worker\_disk\_caching](#input\_docker\_gpu\_worker\_disk\_caching) | The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite. | `string` | `"ReadWrite"` | no |
| <a name="input_docker_gpu_worker_disk_size_gb"></a> [docker\_gpu\_worker\_disk\_size\_gb](#input\_docker\_gpu\_worker\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `number` | `500` | no |
| <a name="input_docker_gpu_worker_public_key"></a> [docker\_gpu\_worker\_public\_key](#input\_docker\_gpu\_worker\_public\_key) | An ssh public key for the admin user | `any` | n/a | yes |
| <a name="input_docker_gpu_worker_sg"></a> [docker\_gpu\_worker\_sg](#input\_docker\_gpu\_worker\_sg) | Security group for the docker swarm masters | `list(map(any))` | <pre>[<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_port_range": "22",<br>    "direction": "Inbound",<br>    "name": "ssh",<br>    "priority": 100,<br>    "protocol": "Tcp",<br>    "source_address_prefix": "*",<br>    "source_port_range": "*"<br>  }<br>]</pre> | no |
| <a name="input_docker_gpu_worker_storage_account_type"></a> [docker\_gpu\_worker\_storage\_account\_type](#input\_docker\_gpu\_worker\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard\_LRS, StandardSSD\_LRS and Premium\_LRS. Changing this forces a new resource to be created. | `string` | `"Standard_LRS"` | no |
| <a name="input_docker_swarm_master_admin_username"></a> [docker\_swarm\_master\_admin\_username](#input\_docker\_swarm\_master\_admin\_username) | The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `map` | <pre>{<br>  "centos": "centos",<br>  "ubuntu": "ubuntu"<br>}</pre> | no |
| <a name="input_docker_swarm_master_disk_caching"></a> [docker\_swarm\_master\_disk\_caching](#input\_docker\_swarm\_master\_disk\_caching) | The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite. | `string` | `"ReadWrite"` | no |
| <a name="input_docker_swarm_master_disk_size_gb"></a> [docker\_swarm\_master\_disk\_size\_gb](#input\_docker\_swarm\_master\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `number` | `100` | no |
| <a name="input_docker_swarm_master_public_key"></a> [docker\_swarm\_master\_public\_key](#input\_docker\_swarm\_master\_public\_key) | An ssh public key for the admin user | `any` | n/a | yes |
| <a name="input_docker_swarm_master_sg"></a> [docker\_swarm\_master\_sg](#input\_docker\_swarm\_master\_sg) | Security group for the docker swarm masters | `list(map(any))` | <pre>[<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_port_range": "22",<br>    "direction": "Inbound",<br>    "name": "ssh",<br>    "priority": 100,<br>    "protocol": "Tcp",<br>    "source_address_prefix": "*",<br>    "source_port_range": "*"<br>  },<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_port_range": "443",<br>    "direction": "Inbound",<br>    "name": "https",<br>    "priority": 101,<br>    "protocol": "Tcp",<br>    "source_address_prefix": "*",<br>    "source_port_range": "*"<br>  },<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_port_range": "80",<br>    "direction": "Inbound",<br>    "name": "http",<br>    "priority": 102,<br>    "protocol": "Tcp",<br>    "source_address_prefix": "*",<br>    "source_port_range": "*"<br>  }<br>]</pre> | no |
| <a name="input_docker_swarm_master_storage_account_type"></a> [docker\_swarm\_master\_storage\_account\_type](#input\_docker\_swarm\_master\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard\_LRS, StandardSSD\_LRS and Premium\_LRS. Changing this forces a new resource to be created. | `string` | `"Standard_LRS"` | no |
| <a name="input_docker_swarm_worker_admin_username"></a> [docker\_swarm\_worker\_admin\_username](#input\_docker\_swarm\_worker\_admin\_username) | The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `map` | <pre>{<br>  "centos": "centos",<br>  "ubuntu": "ubuntu"<br>}</pre> | no |
| <a name="input_docker_swarm_worker_disk_caching"></a> [docker\_swarm\_worker\_disk\_caching](#input\_docker\_swarm\_worker\_disk\_caching) | The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite. | `string` | `"ReadWrite"` | no |
| <a name="input_docker_swarm_worker_disk_size_gb"></a> [docker\_swarm\_worker\_disk\_size\_gb](#input\_docker\_swarm\_worker\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `number` | `250` | no |
| <a name="input_docker_swarm_worker_public_key"></a> [docker\_swarm\_worker\_public\_key](#input\_docker\_swarm\_worker\_public\_key) | An ssh public key for the admin user | `any` | n/a | yes |
| <a name="input_docker_swarm_worker_sg"></a> [docker\_swarm\_worker\_sg](#input\_docker\_swarm\_worker\_sg) | Security group for the docker swarm masters | `list(map(any))` | <pre>[<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_port_range": "22",<br>    "direction": "Inbound",<br>    "name": "ssh",<br>    "priority": 100,<br>    "protocol": "Tcp",<br>    "source_address_prefix": "*",<br>    "source_port_range": "*"<br>  }<br>]</pre> | no |
| <a name="input_docker_swarm_worker_storage_account_type"></a> [docker\_swarm\_worker\_storage\_account\_type](#input\_docker\_swarm\_worker\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard\_LRS, StandardSSD\_LRS and Premium\_LRS. Changing this forces a new resource to be created. | `string` | `"Standard_LRS"` | no |
| <a name="input_gpu_shape"></a> [gpu\_shape](#input\_gpu\_shape) | n/a | `string` | `"demo"` | no |
| <a name="input_gpu_shapes"></a> [gpu\_shapes](#input\_gpu\_shapes) | n/a | `map` | <pre>{<br>  "constrained": {<br>    "pool_production_replicas": 1,<br>    "pool_production_units": 7,<br>    "pool_training_replicas": 1,<br>    "pool_training_units": 1<br>  },<br>  "demo": {<br>    "pool_production_replicas": 1,<br>    "pool_production_units": 3,<br>    "pool_training_replicas": 1,<br>    "pool_training_units": 1<br>  },<br>  "full": {<br>    "pool_production_replicas": 1,<br>    "pool_production_units": 10,<br>    "pool_training_replicas": 6,<br>    "pool_training_units": 6<br>  }<br>}</pre> | no |
| <a name="input_gpu_zone"></a> [gpu\_zone](#input\_gpu\_zone) | The zone GPU Nodes should be deployed to | `string` | `""` | no |
| <a name="input_image_offer"></a> [image\_offer](#input\_image\_offer) | Specifies the offer of the image used to create the virtual machines. | `map` | <pre>{<br>  "centos": "CentOS",<br>  "ubuntu": "UbuntuServer"<br>}</pre> | no |
| <a name="input_image_publisher"></a> [image\_publisher](#input\_image\_publisher) | Specifies the publisher of the image used to create the virtual machines. | `map` | <pre>{<br>  "centos": "OpenLogic",<br>  "ubuntu": "Canonical"<br>}</pre> | no |
| <a name="input_image_sku"></a> [image\_sku](#input\_image\_sku) | Specifies the SKU of the image used to create the virtual machines. | `map` | <pre>{<br>  "centos": "7.5",<br>  "ubuntu": "18.04-LTS"<br>}</pre> | no |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | Specifies the version of the image used to create the virtual machines. | `map` | <pre>{<br>  "centos": "latest",<br>  "ubuntu": "latest"<br>}</pre> | no |
| <a name="input_ip_version"></a> [ip\_version](#input\_ip\_version) | The IP Version to use, IPv6 or IPv4. | `string` | `"IPv4"` | no |
| <a name="input_is_suspended"></a> [is\_suspended](#input\_is\_suspended) | Are the VMs slated for deletion | `bool` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The regional location of your Azure environemnt | `string` | `"East US"` | no |
| <a name="input_operatingsystem"></a> [operatingsystem](#input\_operatingsystem) | The Operating System of the virtual machines. | `string` | `"ubuntu"` | no |
| <a name="input_airwave_size"></a> [airwave\_size](#input\_airwave\_size) | The internal common name of your Azure Compute Virtual Machine | `string` | n/a | yes |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | The allocation method used for the Private IP Address. Possible values are Dynamic and Static. | `string` | `"Dynamic"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The regional location of your Azure environemnt | `string` | `"dev"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. | `string` | `"Standard"` | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The name postfix that will be added to all resources | `string` | `"dev"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet ID of your Azure environment | `string` | n/a | yes |
| <a name="input_swarm_gpu_worker_flavor"></a> [swarm\_gpu\_worker\_flavor](#input\_swarm\_gpu\_worker\_flavor) | n/a | `map` | <pre>{<br>  "fast_solo": "Standard_NC4as_T4_v3",<br>  "moderate_few": "Standard_NC4as_T4_v3",<br>  "moderate_solo": "Standard_NC4as_T4_v3",<br>  "slow_few": "Standard_NC4as_T4_v3",<br>  "test": "Standard_A8m_v2"<br>}</pre> | no |
| <a name="input_swarm_manager_count"></a> [swarm\_manager\_count](#input\_swarm\_manager\_count) | n/a | `map` | <pre>{<br>  "fast_solo": 3,<br>  "moderate_few": 3,<br>  "moderate_solo": 3,<br>  "slow_few": 3,<br>  "test": 1<br>}</pre> | no |
| <a name="input_swarm_manager_flavor"></a> [swarm\_manager\_flavor](#input\_swarm\_manager\_flavor) | n/a | `map` | <pre>{<br>  "fast_solo": "Standard_D2_v4",<br>  "moderate_few": "Standard_D2_v4",<br>  "moderate_solo": "Standard_D2_v4",<br>  "slow_few": "Standard_D2_v4",<br>  "test": "Standard_D2_v4"<br>}</pre> | no |
| <a name="input_swarm_worker_count"></a> [swarm\_worker\_count](#input\_swarm\_worker\_count) | n/a | `map` | <pre>{<br>  "fast_solo": 1,<br>  "moderate_few": 3,<br>  "moderate_solo": 1,<br>  "slow_few": 3,<br>  "test": 1<br>}</pre> | no |
| <a name="input_swarm_worker_flavor"></a> [swarm\_worker\_flavor](#input\_swarm\_worker\_flavor) | n/a | `map` | <pre>{<br>  "fast_solo": "Standard_D32d_v4",<br>  "moderate_few": "Standard_D32d_v4",<br>  "moderate_solo": "Standard_D32d_v4",<br>  "slow_few": "Standard_D32d_v4",<br>  "test": "Standard_A8m_v2"<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags on the resources | `map(string)` | `{}` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone Nodes should be deployed to | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_docker_gpu_workers"></a> [docker\_gpu\_workers](#output\_docker\_gpu\_workers) | n/a |
| <a name="output_docker_gpu_workers_all"></a> [docker\_gpu\_workers\_all](#output\_docker\_gpu\_workers\_all) | n/a |
| <a name="output_docker_gpu_workers_network_interface_id"></a> [docker\_gpu\_workers\_network\_interface\_id](#output\_docker\_gpu\_workers\_network\_interface\_id) | n/a |
| <a name="output_docker_swarm_masters"></a> [docker\_swarm\_masters](#output\_docker\_swarm\_masters) | n/a |
| <a name="output_docker_swarm_masters_all"></a> [docker\_swarm\_masters\_all](#output\_docker\_swarm\_masters\_all) | n/a |
| <a name="output_docker_swarm_masters_network_interface_id"></a> [docker\_swarm\_masters\_network\_interface\_id](#output\_docker\_swarm\_masters\_network\_interface\_id) | n/a |
| <a name="output_docker_swarm_masters_private_ip_address"></a> [docker\_swarm\_masters\_private\_ip\_address](#output\_docker\_swarm\_masters\_private\_ip\_address) | n/a |
| <a name="output_docker_swarm_workers"></a> [docker\_swarm\_workers](#output\_docker\_swarm\_workers) | n/a |
| <a name="output_docker_swarm_workers_all"></a> [docker\_swarm\_workers\_all](#output\_docker\_swarm\_workers\_all) | n/a |
| <a name="output_docker_swarm_workers_network_interface_id"></a> [docker\_swarm\_workers\_network\_interface\_id](#output\_docker\_swarm\_workers\_network\_interface\_id) | n/a |
