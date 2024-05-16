variable "storage_account_name" {
  type        = string
  default     = ""
  description = "The storage account name"
}


variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = " Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created."
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool."
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags on the resources"
}

variable "buckets" {
  type        = set(string)
  default     = ["core", "analysis", "ingest", "config"]
  description = "A list of Storage Account postfix names"
}

variable "enable_https_traffic_only" {
  type        = bool
  default     = true
  description = "Boolean flag which forces HTTPS if enabled, see here for more information."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2."
}

variable "storage_container_access_type" {
  type        = string
  default     = "private"
  description = "The Access Level configured for this Container. Possible values are blob, container or private."
}
