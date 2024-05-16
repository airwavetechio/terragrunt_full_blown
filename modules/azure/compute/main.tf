terraform {
  required_version = ">= 1.0.9"
}

provider "azurerm" {
  features {}
}

// Docker Swarm Masters
resource "azurerm_public_ip" "docker_swarm_master" {
  count               = var.is_suspended ? 0 : var.swarm_manager_count[var.airwave_size]
  name                = "public-ip-docker-swarm-master-${var.subdomain}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
  ip_version          = var.ip_version

  tags = var.tags

}

resource "azurerm_network_interface" "docker_swarm_master" {
  count               = var.is_suspended ? 0 : var.swarm_manager_count[var.airwave_size]
  name                = "nic-docker-swarm-master-${var.subdomain}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  enable_accelerated_networking = var.enable_accelerated_networking

  ip_configuration {
    name                          = "${var.subdomain}-${count.index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.docker_swarm_master[count.index].id
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "docker_swarm_master" {
  count                     = var.is_suspended ? 0 : var.swarm_manager_count[var.airwave_size]
  network_interface_id      = azurerm_network_interface.docker_swarm_master[count.index].id
  network_security_group_id = var.docker_swarm_master_azurerm_network_security_group_id
}

resource "azurerm_linux_virtual_machine" "docker_swarm_master" {
  count                 = var.is_suspended ? 0 : var.swarm_manager_count[var.airwave_size]
  name                  = "docker-swarm-master-${var.subdomain}-${count.index}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.docker_swarm_master[count.index].id]
  size                  = var.swarm_manager_flavor[var.airwave_size]
  admin_username        = var.docker_swarm_master_admin_username[var.operatingsystem]
  zone                  = var.zone

  source_image_reference {
    publisher = var.image_publisher[var.operatingsystem]
    offer     = var.image_offer[var.operatingsystem]
    sku       = var.image_sku[var.operatingsystem]
    version   = var.image_version[var.operatingsystem]
  }

  os_disk {
    name                 = "docker-swarm-master-os-disk-${count.index}"
    caching              = var.docker_swarm_master_disk_caching
    storage_account_type = var.docker_swarm_master_storage_account_type
    disk_size_gb         = var.docker_swarm_master_disk_size_gb
  }

  admin_ssh_key {
    username   = var.docker_swarm_master_admin_username[var.operatingsystem]
    public_key = var.docker_swarm_public_key
  }

  tags = var.tags
}

// Docker Swarm Worker
resource "azurerm_public_ip" "docker_swarm_worker" {
  count               = var.is_suspended ? 0 : var.swarm_worker_count[var.airwave_size]
  name                = "public-ip-docker-swarm-worker-${var.subdomain}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
  ip_version          = var.ip_version

  tags = var.tags
}

resource "azurerm_network_interface" "docker_swarm_worker" {
  count               = var.is_suspended ? 0 : var.swarm_worker_count[var.airwave_size]
  name                = "nic-docker-swarm-worker-${var.subdomain}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  enable_accelerated_networking = var.enable_accelerated_networking

  ip_configuration {
    name                          = "${var.subdomain}-${count.index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.docker_swarm_worker[count.index].id
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "docker_swarm_worker" {
  count                     = var.is_suspended ? 0 : var.swarm_worker_count[var.airwave_size]
  network_interface_id      = azurerm_network_interface.docker_swarm_worker[count.index].id
  network_security_group_id = var.docker_swarm_worker_azurerm_network_security_group_id
}

resource "azurerm_linux_virtual_machine" "docker_swarm_worker" {
  count                 = var.is_suspended ? 0 : var.swarm_worker_count[var.airwave_size]
  name                  = "docker-swarm-worker-${var.subdomain}-${count.index}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.docker_swarm_worker[count.index].id]
  size                  = var.swarm_worker_flavor[var.airwave_size]
  admin_username        = var.docker_swarm_worker_admin_username[var.operatingsystem]
  zone                  = var.zone

  source_image_reference {
    publisher = var.image_publisher[var.operatingsystem]
    offer     = var.image_offer[var.operatingsystem]
    sku       = var.image_sku[var.operatingsystem]
    version   = var.image_version[var.operatingsystem]
  }

  os_disk {
    name                 = "docker-swarm-worker-os-disk-${count.index}"
    caching              = var.docker_swarm_worker_disk_caching
    storage_account_type = var.docker_swarm_worker_storage_account_type
    disk_size_gb         = var.docker_swarm_worker_disk_size_gb
  }

  admin_ssh_key {
    username   = var.docker_swarm_worker_admin_username[var.operatingsystem]
    public_key = var.docker_swarm_public_key
  }

  tags = var.tags
}

// Docker GPU Worker
resource "azurerm_public_ip" "docker_gpu_worker" {
  count               = var.is_suspended ? 0 : var.gpu_shapes[var.gpu_shape].pool_training_units + var.gpu_shapes[var.gpu_shape].pool_production_units
  name                = "public-ip-docker-gpu-worker-${var.subdomain}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
  ip_version          = var.ip_version

  tags = var.tags
}

resource "azurerm_network_interface" "docker_gpu_worker" {
  count               = var.is_suspended ? 0 : var.gpu_shapes[var.gpu_shape].pool_training_units + var.gpu_shapes[var.gpu_shape].pool_production_units
  name                = "nic-docker-gpu-worker-${var.subdomain}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Accelerated is not supported DEV-257
  #enable_accelerated_networking = var.enable_accelerated_networking

  ip_configuration {
    name                          = "${var.subdomain}-${count.index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.docker_gpu_worker[count.index].id
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "docker_gpu_worker" {
  count                     = var.is_suspended ? 0 : var.gpu_shapes[var.gpu_shape].pool_training_units + var.gpu_shapes[var.gpu_shape].pool_production_units
  network_interface_id      = azurerm_network_interface.docker_gpu_worker[count.index].id
  network_security_group_id = var.docker_gpu_worker_azurerm_network_security_group_id
}

resource "azurerm_linux_virtual_machine" "docker_gpu_worker" {
  count                 = var.is_suspended ? 0 : var.gpu_shapes[var.gpu_shape].pool_training_units + var.gpu_shapes[var.gpu_shape].pool_production_units
  name                  = "docker-gpu-worker-${var.subdomain}-${count.index}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.docker_gpu_worker[count.index].id]
  size                  = var.swarm_gpu_worker_flavor[var.airwave_size]
  admin_username        = var.docker_gpu_worker_admin_username[var.operatingsystem]
  zone                  = var.gpu_zone

  source_image_reference {
    publisher = var.image_publisher[var.operatingsystem]
    offer     = var.image_offer[var.operatingsystem]
    sku       = var.image_sku[var.operatingsystem]
    version   = var.image_version[var.operatingsystem]
  }

  os_disk {
    name                 = "docker-gpu-worker-os-disk-${count.index}"
    caching              = var.docker_gpu_worker_disk_caching
    storage_account_type = var.docker_gpu_worker_storage_account_type
    disk_size_gb         = var.docker_gpu_worker_disk_size_gb
  }

  admin_ssh_key {
    username   = var.docker_gpu_worker_admin_username[var.operatingsystem]
    public_key = var.docker_swarm_public_key
  }

  tags = var.tags
}
