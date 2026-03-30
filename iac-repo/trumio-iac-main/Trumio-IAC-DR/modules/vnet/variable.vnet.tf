
#Virtual network variables
variable "vnet_name" {
    description = "Virtual network name"
}

variable "vnet_location" {
    description = "Virtual Network location"
}

variable "vnet_rg_name" {
    description = "Virtual network resource group name"
}

variable "vnet_address_prefix" {
    description = "Virtual Network address space"
    type = list(string)
}

variable "vnet_tags" {
    description = "virtual network tags"
}

variable "subnets" {
    description = "subnet details"
    type        = map(any)
}

