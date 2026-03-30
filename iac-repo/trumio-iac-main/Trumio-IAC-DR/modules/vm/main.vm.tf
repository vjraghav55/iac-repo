# # Public IP
# resource "azurerm_public_ip" "public_ip_wts" {
#   name                = var.public_ip_wts_name
#   location            = var.public_ip_wts_location
#   resource_group_name = var.public_ip_wts_rg_name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# Network Security Group and rules
resource "azurerm_network_security_group" "nsg_wts" {
  name                = var.nsg_wts_name
  location            = var.nsg_wts_location
  resource_group_name = var.nsg_wts_rg_name

  dynamic "security_rule" {
    for_each = var.nsg_wts_security_rule
    content {
      name                        = security_rule.value.name
      priority                    = security_rule.value.priority
      direction                   = security_rule.value.direction
      access                      = security_rule.value.access
      protocol                    = security_rule.value.protocol
      source_port_range           = security_rule.value.source_port_range
      destination_port_range      = security_rule.value.destination_port_range
      source_address_prefix       = security_rule.value.source_address_prefix
      destination_address_prefix  = security_rule.value.destination_address_prefix
    }
  }
  tags = var.nsg_wts_tags
}

# Network interface
resource "azurerm_network_interface" "nic_wts" {
  name                = var.nic_wts_name
  location            = var.nic_wts_location
  resource_group_name = var.nic_wts_rg_name

  ip_configuration {
    name                          = "nic-wts"
    subnet_id                     = var.nic_wts_snet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.nic_wts_priv_ipadd    
    #public_ip_address_id          = azurerm_public_ip.public_ip_wts.id
  }
  tags = var.nic_wts_tags
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nic_wts_nsg" {
  network_interface_id      = azurerm_network_interface.nic_wts.id
  network_security_group_id = azurerm_network_security_group.nsg_wts.id
}

# Windows Virtual machine
resource "azurerm_windows_virtual_machine" "vm_wts" {
  name                      = var.vm_wts_name
  resource_group_name       = var.vm_wts_rg_name
  location                  = var.vm_wts_location
  size                      = var.vm_wts_size
  admin_username            = var.vm_wts_adm_usr
  admin_password            = var.vm_wts_adm_pwd
  network_interface_ids     = [azurerm_network_interface.nic_wts.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_wts_image_publisher
    offer     = var.vm_wts_image_offer
    sku       = var.vm_wts_image_sku
    version   = "latest"
  }
  tags = var.vm_wts_tags
}

# # Virtual Machine Extension
# resource "azurerm_virtual_machine_extension" "win_vm_extension" {
#   name                 = "enable-winrm-extension"
#   virtual_machine_id   = azurerm_windows_virtual_machine.vm_wts.id
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.10"

#   protected_settings = <<SETTINGS
#   {
#     "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.tf.rendered)}')) | Out-File -filepath config.ps1\" && powershell -ExecutionPolicy Unrestricted -File config.ps1"
#   }
#   SETTINGS

#   depends_on = [azurerm_windows_virtual_machine.vm_wts]
# }

# data "template_file" "tf" {
#   template = file("${path.module}/config.ps1")
# }

# # Installations using null_resource
# resource "null_resource" "installations" {
#   provisioner "file" {
#     connection {
#       type        = "winrm"
#       user        = "trumiouser"
#       password    = "T#k@!bA_&#$@5WvrV1M"
#       host        = azurerm_public_ip.public_ip_wts.ip_address  
#       port        = 5985  
#       https       = false
#       timeout     = "2m"
#       insecure    = true  
#     }
#     source      = "${path.module}/install.ps1"  
#     destination = "desktop/install.ps1"
#   }

#   provisioner "remote-exec" {
#     connection {
#       type        = "winrm"
#       user        = "trumiouser"
#       password    = "T#k@!bA_&#$@5WvrV1M"
#       host        = azurerm_public_ip.public_ip_wts.ip_address
#       port        = 5985
#       https       = false
#       timeout     = "20m"  # Adjust timeout value if needed
#       insecure    = true  # Adjust based on security requirements
#     }
#     inline = [
#       "powershell.exe -File C:/Users/trumiouser/desktop/install.ps1"
#     ]
#   }

#   depends_on = [azurerm_windows_virtual_machine.vm_wts, azurerm_virtual_machine_extension.win_vm_extension]
# }


# Linux virtual machine

# resource "azurerm_network_security_group" "nsg_ls" {
#   name                = var.nsg_ls_name
#   location            = var.nsg_ls_location
#   resource_group_name = var.nsg_ls_rg_name

#   dynamic "security_rule" {
#     for_each = var.nsg_ls_security_rule
#     content {
#       name                        = security_rule.value.name
#       priority                    = security_rule.value.priority
#       direction                   = security_rule.value.direction
#       access                      = security_rule.value.access
#       protocol                    = security_rule.value.protocol
#       source_port_range           = security_rule.value.source_port_range
#       destination_port_range      = security_rule.value.destination_port_range
#       source_address_prefix       = security_rule.value.source_address_prefix
#       destination_address_prefix  = security_rule.value.destination_address_prefix
#     }
#   }
#   tags = var.nsg_ls_tags
# }

# resource "azurerm_network_interface" "nic_ls" {
#   name                = var.nic_ls_name
#   location            = var.nic_ls_location
#   resource_group_name = var.nic_ls_rg_name

#   ip_configuration {
#     name                          = "frontend-ip"
#     subnet_id                     = var.nic_ls_snet_id
#     private_ip_address_allocation = "Static"
#     private_ip_address            = var.nic_ls_priv_ipadd
#     # public_ip_address_id        = azurerm_public_ip.public-ip.id
#   }
#   tags = var.nic_ls_tags
# }

# resource "azurerm_network_interface_security_group_association" "nic_ls_nsg" {
#   network_interface_id      = azurerm_network_interface.nic_ls.id
#   network_security_group_id = azurerm_network_security_group.nsg_ls.id
# }

# resource "tls_private_key" "ssh_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "azurerm_linux_virtual_machine" "vm_ls" {
#   name                             = var.vm_ls_name
#   resource_group_name              = var.vm_ls_rg_name
#   location                         = var.vm_ls_rg_location
#   size                             = var.vm_ls_size
#   admin_username                   = "adminuser"
#   disable_password_authentication  = true
#   network_interface_ids            = [azurerm_network_interface.nic_ls.id]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = tls_private_key.ssh_key.public_key_openssh
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
#   tags = var.vm_ls_tags
# }


