variable "keyvault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "keyvault_location" {
  description = "Location of the Key Vault"
  type        = string
}

variable "keyvault_resource_group_name" {
  description = "Resource Group name of the Key Vault"
  type        = string
}

variable "keyvault_sku_name" {
  description = "SKU name of the Key Vault"
  type        = string
}

variable "soft_delete_retention_days" {
  description = "Number of days soft deleted keys should be retained for. Value should be between 7 and 90."
  type        = number
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "object_ids" {
  description = "List of Object IDs to assign permissions to"
  type        = list(string)
}

variable "secrets" {
  description = "A map of secrets to be stored in the Key Vault."
  type        = map(string)
  }