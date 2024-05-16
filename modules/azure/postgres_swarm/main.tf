terraform {
  required_version = ">= 1.0.9"
}

resource "azurerm_public_ip" "postgres" {
  name                = "public-ip-postgres-${var.subdomain}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
  ip_version          = var.ip_version

  tags = var.tags

}

resource "azurerm_network_security_group" "postgres" {
  name                = "postgres-nsg-${var.subdomain}"
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


resource "azurerm_network_interface" "postgres" {
  name                = "nic-docker-postgres-${var.subdomain}"
  location            = var.location
  resource_group_name = var.resource_group_name

  enable_accelerated_networking = var.enable_accelerated_networking

  ip_configuration {
    name                          = "ip-configuration-postgres-${var.subdomain}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.postgres.id
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "postgres" {
  network_interface_id      = azurerm_network_interface.postgres.id
  network_security_group_id = azurerm_network_security_group.postgres.id
}

resource "azurerm_linux_virtual_machine" "postgres" {
  name                  = "postgres-${var.subdomain}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.postgres.id]
  size                  = var.size
  admin_username        = var.admin_username[var.operatingsystem]

  source_image_reference {
    publisher = var.image_publisher[var.operatingsystem]
    offer     = var.image_offer[var.operatingsystem]
    sku       = var.image_sku[var.operatingsystem]
    version   = var.image_version[var.operatingsystem]
  }

  os_disk {
    name                 = "postgres-${var.subdomain}-disk"
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size_gb
  }

  admin_ssh_key {
    username   = var.admin_username[var.operatingsystem]
    public_key = var.public_key
  }

}


resource "azurerm_managed_disk" "postgres_data" {
  name                 = "postgres-${var.subdomain}-pg_datadisk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "100"
}

resource "azurerm_virtual_machine_data_disk_attachment" "postgres_data" {
  managed_disk_id    = azurerm_managed_disk.postgres_data.id
  virtual_machine_id = azurerm_linux_virtual_machine.postgres.id
  lun                = "10"
  caching            = "ReadWrite"
}

# resource "azurerm_backup_policy_vm" "postgres" {
#   name                = "${var.subdomain}-postgres-recovery-vault-policy"
#   resource_group_name = var.resource_group_name
#   recovery_vault_name = azurerm_recovery_services_vault.postgres.name

#   timezone = "UTC"

#   backup {
#     frequency = var.backup_frequency
#     time      = var.backup_time
#   }

#   retention_daily {
#     count = var.retention_daily_count
#   }

#   retention_weekly {
#     count    = var.retention_weekly_count
#     weekdays = var.retention_weekly_weekdays
#   }

#   retention_monthly {
#     count    = var.retention_monthly_count
#     weekdays = var.retention_monthly_weekdays
#     weeks    = var.retention_monthly_weeks
#   }

#   retention_yearly {
#     count    = var.retention_yearly_count
#     weekdays = var.retention_yearly_weekdays
#     weeks    = var.retention_yearly_weeks
#     months   = var.retention_yearly_months
#   }
# }

# resource "azurerm_backup_protected_vm" "postgres" {
#   resource_group_name = var.resource_group_name
#   recovery_vault_name = azurerm_recovery_services_vault.postgres.name
#   source_vm_id        = azurerm_linux_virtual_machine.postgres.id
#   backup_policy_id    = azurerm_backup_policy_vm.postgres.id
# }