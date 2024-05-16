resource "azurerm_virtual_network" "cluster" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.virtual_network_address_prefix]

  subnet {
    name           = var.aks_subnet_name
    address_prefix = var.aks_subnet_address_prefix
  }

  subnet {
    name           = "appgwsubnet"
    address_prefix = var.app_gateway_subnet_address_prefix
  }

  tags = var.tags
}

data "azurerm_subnet" "akssubnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = azurerm_virtual_network.cluster.name
  resource_group_name  = var.resource_group_name
  depends_on           = [azurerm_virtual_network.cluster]
}

data "azurerm_subnet" "appgwsubnet" {
  name                 = var.application_gateway_subnet_name
  virtual_network_name = azurerm_virtual_network.cluster.name
  resource_group_name  = var.resource_group_name
  depends_on           = [azurerm_virtual_network.cluster]
}

# Public Ip 
resource "azurerm_public_ip" "cluster" {
  name                = "publicIp1"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_application_gateway" "cluster" {
  name                = var.app_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = var.app_gateway_sku
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = data.azurerm_subnet.appgwsubnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.cluster.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = 1
  }

  tags = var.tags

  depends_on = [azurerm_virtual_network.cluster, azurerm_public_ip.cluster]
}
