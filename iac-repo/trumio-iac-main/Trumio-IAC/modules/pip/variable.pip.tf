
##App-GW
variable "app_gw_pip_name" {
  description = "Name for the Public IP address of the Application Gateway"
  type        = string
}

variable "app_gw_pip_location" {
  description = "Location for the Public IP address of the Application Gateway"
  type        = string
}

variable "app_gw_pip_rg_name" {
  description = "Resource Group name for the Public IP address of the Application Gateway"
  type        = string
}

variable "app_gw_pip_tags" {
  description = "Tags for the Public IP address of the Application Gateway"
  type        = map(string)
}


