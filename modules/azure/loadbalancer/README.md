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
| [azurerm_lb.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_probe.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.rule01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_lb_rule.rule02](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_network_interface_backend_address_pool_association.docker_swarm_master](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | Defines the allocation method for this IP address. Possible values are Static or Dynamic. | `string` | `"Static"` | no |
| <a name="input_docker_swarm_masters_networking_interface_id"></a> [docker\_swarm\_masters\_networking\_interface\_id](#input\_docker\_swarm\_masters\_networking\_interface\_id) | The Network Interface IDs for Docker Swarm Masters | `list(string)` | n/a | yes |
| <a name="input_interval_in_seconds"></a> [interval\_in\_seconds](#input\_interval\_in\_seconds) | The interval, in seconds between probes to the backend endpoint for health status. The minimum value is 5. | `number` | `60` | no |
| <a name="input_location"></a> [location](#input\_location) | The regional location of your Azure environemnt | `string` | `"East US"` | no |
| <a name="input_number_of_probes"></a> [number\_of\_probes](#input\_number\_of\_probes) | The number of failed probe attempts after which the backend endpoint is removed from rotation. NumberOfProbes multiplied by intervalInSeconds value must be greater or equal to 10. Endpoints are returned to rotation when at least one probe is successful. | `number` | `2` | no |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static. | `string` | `"Dynamic"` | no |
| <a name="input_probe_port"></a> [probe\_port](#input\_probe\_port) | Specifies the port the probe should be listening to. | `number` | `443` | no |
| <a name="input_probe_protocol"></a> [probe\_protocol](#input\_probe\_protocol) | Specifies the protocol of the end point. Possible values are Http, Https or Tcp. If Tcp is specified, a received ACK is required for the probe to be successful. If Http is specified, a 200 OK response from the specified URI is required for the probe to be successful. | `string` | `"Https"` | no |
| <a name="input_public_ip_sku"></a> [public\_ip\_sku](#input\_public\_ip\_sku) | The SKU of the Public IP. Accepted values are Basic and Standard. | `string` | `"Standard"` | no |
| <a name="input_request_path"></a> [request\_path](#input\_request\_path) | The URI used for requesting health status from the backend endpoint. Required if protocol is set to Http or Https. Otherwise, it is not allowed. | `string` | `"/health"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The regional location of your Azure environemnt | `string` | `"dev"` | no |
| <a name="input_rule01_backend_port"></a> [rule01\_backend\_port](#input\_rule01\_backend\_port) | The port used for internal connections on the endpoint. Possible values range between 1 and 65535, inclusive. | `string` | `"443"` | no |
| <a name="input_rule01_frontend_port"></a> [rule01\_frontend\_port](#input\_rule01\_frontend\_port) | The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 1 and 65534, inclusive. | `string` | `"443"` | no |
| <a name="input_rule01_protocol"></a> [rule01\_protocol](#input\_rule01\_protocol) | The transport protocol for the external endpoint. Possible values are Udp, Tcp or All. | `string` | `"Tcp"` | no |
| <a name="input_rule02_backend_port"></a> [rule02\_backend\_port](#input\_rule02\_backend\_port) | The port used for internal connections on the endpoint. Possible values range between 1 and 65535, inclusive. | `string` | `"80"` | no |
| <a name="input_rule02_frontend_port"></a> [rule02\_frontend\_port](#input\_rule02\_frontend\_port) | The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 1 and 65534, inclusive. | `string` | `"80"` | no |
| <a name="input_rule02_protocol"></a> [rule02\_protocol](#input\_rule02\_protocol) | The transport protocol for the external endpoint. Possible values are Udp, Tcp or All. | `string` | `"Tcp"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway | `string` | `"Standard"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | The Sku Tier of this Load Balancer. Possible values are Global and Regional. Changing this forces a new resource to be created. | `string` | `"Regional"` | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The name postfix that will be added to all resources | `string` | `"dev"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags on the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Load Balancer ID. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | n/a |
