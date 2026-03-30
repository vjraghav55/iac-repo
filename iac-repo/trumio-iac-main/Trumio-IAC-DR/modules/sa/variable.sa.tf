
#Storage account variables
variable "sa_name" {
  description = "Name for the storage account."
  type        = string
}

variable "sa_location" {
    description = "Storage account location"
}

variable "sa_rg_name" {
    description = "Storage account resource group name"
}

variable "sa_account_tier" {
    description = "Storage account tier"   
}

variable "sa_account_kind" {
    description = "Storage account kind"   
}

variable "sa_access_tier" {
    description = "Storage access tier"   
}

variable "sa_account_replication_type" {
    description = "Replication type of atorage account"
}

variable "sa_tags" {
    description = "Storage account tags"
}


variable "cors_rule" {
  description = "List of origins that are allowed to access the storage account."
  type        = list(object({
    allowed_origins = optional(list(string),null)
    allowed_methods = optional(list(string),null)
    allowed_headers = optional(list(string),null)
    exposed_headers = optional(list(string),null)
    max_age_in_seconds = optional(number,null)
  }))
}

variable "static_website_config" {
  description = ""
  type        = list(object({
    index_document = optional(string,null)
    error_404_document = optional(string,null)

  }))
}

variable "containers" {
    description = "container details"
    type = map(object({
      name                 = string
      container_access_type = string
    }))
}
