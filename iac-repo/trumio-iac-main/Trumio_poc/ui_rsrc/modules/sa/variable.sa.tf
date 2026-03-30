
#Storage account variables
variable "sa_name" {
    description = "Defines storage account name"
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

variable "containers" {
    description = "container details"
    type        = map(any)
}
