terraform {
  required_version = ">= 1.0.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_public_ip" "elasticsearch" {
  name                = "public-ip-elasticsearch-${var.subdomain}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
  ip_version          = var.ip_version

  tags = var.tags

}

resource "azurerm_network_security_group" "elasticsearch" {
  name                = "elasticsearch-nsg-${var.subdomain}"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.allowed_ips_list
    content {
      name                       = "Rule: ${security_rule.value}"
      priority                   = 100 + security_rule.key
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "${security_rule.value}/32"
      destination_address_prefix = "*"
    }
  }

  security_rule {
    name                       = "Rule: Inbound SSH"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  tags = var.tags
}


resource "azurerm_network_interface" "elasticsearch" {
  name                = "nic-docker-elasticsearch-${var.subdomain}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ip-configuration-elasticsearch-${var.subdomain}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.elasticsearch.id
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "elasticsearch" {
  network_interface_id      = azurerm_network_interface.elasticsearch.id
  network_security_group_id = azurerm_network_security_group.elasticsearch.id
}

resource "azurerm_linux_virtual_machine" "elasticsearch" {
  name                  = "elasticsearch-${var.subdomain}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.elasticsearch.id]
  size                  = var.size
  admin_username        = var.admin_username[var.operatingsystem]

  source_image_reference {
    publisher = var.image_publisher[var.operatingsystem]
    offer     = var.image_offer[var.operatingsystem]
    sku       = var.image_sku[var.operatingsystem]
    version   = var.image_version[var.operatingsystem]
  }

  os_disk {
    name                 = "elasticsearch-${var.subdomain}-disk"
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size_gb
  }

  admin_ssh_key {
    username   = var.admin_username[var.operatingsystem]
    public_key = var.public_key
  }

  tags = var.tags

  depends_on = [
    azurerm_network_interface_security_group_association.elasticsearch,
  ]
}
