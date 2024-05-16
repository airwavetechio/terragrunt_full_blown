output "storage_container_info" {
  value = {
    for k, v in azurerm_storage_container.this : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "The ID of the Storage Account."
}

output "storage_account_info" {
  value = {
    id                    = azurerm_storage_account.this.id
    name                  = azurerm_storage_account.this.name
    primary_access_key    = azurerm_storage_account.this.primary_access_key
    secondary_access_key  = azurerm_storage_account.this.secondary_access_key
    primary_location      = azurerm_storage_account.this.primary_location
    primary_blob_endpoint = azurerm_storage_account.this.primary_blob_endpoint
  }
  description = "The Storage Account's info."
}
