
locals {
  backend_address_pool_name      = "${azurerm_virtual_network.cluster.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.cluster.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.cluster.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.cluster.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.cluster.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.cluster.name}-rqrt"
}