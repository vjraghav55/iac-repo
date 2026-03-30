# Windows Terminal Server Variables
# variable "public_ip_wts_name" {
#   description = "Public IP name for Windows terminal server"
# }

# variable "public_ip_wts_location" {
#   description = "Public IP location name for Windows terminal server"
# }

# variable "public_ip_wts_rg_name" {
#   description = "Public IP resource group name for Windows terminal server"
# }

variable "nsg_wts_name" {
  description = "Network Security group name for Windows terminal server"
}

variable "nsg_wts_location" {
  description = "Network Security group location name for Windows terminal server"
}

variable "nsg_wts_rg_name" {
  description = "Network Security group resource group name for Windows terminal server"
}

variable "nsg_wts_security_rule" {
    type = list(object({
        name                        = string  
        priority                    = string  
        direction                   = string  
        access                      = string  
        protocol                    = string  
        source_port_range           = string  
        destination_port_range      = string  
        source_address_prefix       = string  
        destination_address_prefix  = string   
    }))
    default = [
        {
            name                        = "rdp"
            priority                    = "100"
            direction                   = "Inbound"
            access                      = "Allow"
            protocol                    = "Tcp"
            source_port_range           = "*"
            destination_port_range      = "3389"
            source_address_prefix       = "*"
            destination_address_prefix  = "*"    
        },
        {
            name                        = "http"
            priority                    = "200"
            direction                   = "Inbound"
            access                      = "Allow"
            protocol                    = "Tcp"
            source_port_range           = "*"
            destination_port_range      = "5985"
            source_address_prefix       = "*"
            destination_address_prefix  = "*"
        }
    ]
}

variable "nsg_wts_tags" {
  description = "Network Security group name for Windows terminal server tags"
}

variable "nic_wts_name" {
  description = "NIC name for Windows terminal server"
}

variable "nic_wts_location" {
  description = "Network interface card location name for Windows terminal server"
}

variable "nic_wts_rg_name" {
  description = "Network interface card resource group name for Windows terminal server"
}

variable "nic_wts_tags" {
  description = "NIC name for Windows terminal server tags"
}

variable "nic_wts_snet_id" {
  description = "NIC subnet id"
}

variable "nic_wts_priv_ipadd" {
  description = "NIC private IP address"
  default = "10.29.7.6"
}

variable "storage_account_name" {
  type = string
}

variable "storage_account_key" {
  type = string
}

variable "container_name" {
  type = string
}

variable "vm_wts_name" {
  description = "Windows VM terminal server name"
}

variable "vm_wts_location" {
  description = "Resource group location for Windows terminal server"
}

variable "vm_wts_rg_name" {
  description = "Resource group name for Windows terminal server"
}

variable "vm_wts_size" {
  description = "Windows VM terminal server size"
}

variable "vm_wts_adm_usr" {
  description = "Windows VM terminal server username"
}

variable "vm_wts_adm_pwd" {
  description = "Windows VM terminal server password"
}

variable "vm_wts_image_sku" {
  description = "Windows VM terminal server image SKU"
}

variable "vm_wts_image_publisher" {
  description = "Windows VM terminal server image publisher"
}

variable "vm_wts_image_offer" {
  description = "Windows VM terminal server image offer"
}

variable "vm_wts_tags" {
  description = "Windows VM terminal server tags"
}


# # Linux Terminal Server Variables

# variable "nsg_ls_name" {
#   description = "Network Security group name for Linux terminal server"
# }

# variable "nsg_ls_security_rule" {
#     type = list(object({
#     name                        = string  
#     priority                    = string  
#     direction                   = string  
#     access                      = string  
#     protocol                    = string  
#     source_port_range           = string  
#     destination_port_range      = string  
#     source_address_prefix       = string  
#     destination_address_prefix  = string   
#     }))
#     default = [
#         {
#             name                        = "ssh"
#             priority                    = "101"
#             direction                   = "Inbound"
#             access                      = "Allow"
#             protocol                    = "Tcp"
#             source_port_range           = "*"
#             destination_port_range      = "22"
#             source_address_prefix       = "*"
#             destination_address_prefix  = "*"
#         }
#     ]
# }

# variable "nsg_ls_tags" {
#   description = "Network Security group for Linux terminal server tags"
# }

# variable "nic_ls_name" {
#   description = "NIC name for Linux terminal server"
# }

# variable "nic_ls_location" {
#   description = "Network interface card location name for Linux terminal server"
# }

# variable "nic_ls_rg_name" {
#   description = "Network interface card resource group name for Linux terminal server"
# }

# variable "nic_ls_tags" {
#   description = "NIC name for Linux terminal server tags"
# }

# variable "nic_ls_snet_id" {
#   description = "NIC subnet id"
# }

# variable "nic_ls_priv_ipadd" {
#   description = "NIC private IP address"
#   default = "10.30.7.5"
# }

# variable "vm_ls_name" {
#   description = "Linux VM terminal server name"
# }

# variable "vm_ls_location" {
#   description = "Resource group location for Linux terminal server"
# }

# variable "vm_ls_rg_name" {
#   description = "Resource group name for Linux terminal server"
# }

# variable "vm_ls_size" {
#   description = "VM Linux size"
# }

# variable "vm_ls_tags" {
#   description = "Linux VM terminal server tags"
# }

# variable "vm_ls_rg_location" {
#   description = "Resource group location for Linux terminal server"
# }

# variable "vm_ls_rg_name" {
#   description = "Resource group name for Linux terminal server"
# }
