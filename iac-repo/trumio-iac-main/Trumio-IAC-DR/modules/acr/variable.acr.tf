
#ACR variables
variable "acr_name" {
    description = "ACR name"
}

variable "acr_location" {
    description = "ACR location"
}

variable "acr_rg_name" {
    description = "ACR resource group name"
}

variable "acr_sku" {
    description = "ACR sku"
}   

variable "acr_tags" {
    description = "ACR tags"
}

variable "acr_pvt_dns_name" {
    description = "ACR private dns zone name"
}

variable "acr_pvt_dns_vlink" {
    description = "ACR Private DNS virtual network link"
}

variable "acr_vnet_id" {
  description = "ID of the virtual network where ACR will be integrated"
}

variable "acr_subnet_id" {
  description = "ID of the subnet within the virtual network where ACR will be integrated"
}

variable "acr_pep_name" {
    description = "ACR private endpoint name"
}

variable "acr_psvc_name" {
    description = "ACR private endpoint name"
}

variable "acr_pdns_zone_gp" {
    description = "ACR private dns zone name"
}