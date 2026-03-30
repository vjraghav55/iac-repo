output "nsg_wts_id" {
  value = azurerm_network_security_group.nsg_wts.id
}

output "nic_wts_id" {
  value = azurerm_network_interface.nic_wts.id
}

output "nic_wts_private_ip_address" {
  value = azurerm_network_interface.nic_wts.private_ip_address
}

output "nic_wts_virtual_machine_id" {
  value = azurerm_network_interface.nic_wts.virtual_machine_id
}

# output "nsg_ls_id" {
#   value = azurerm_network_security_group.nsg_ls.id
# }

# output "nic_ls_id" {
#   value = azurerm_network_interface.nic_ls.id
# }

# output "nic_ls_private_ip_address" {
#   value = azurerm_network_interface.nic_ls.private_ip_address
# }

# output "nic_ls_virtual_machine_id" {
#   value = azurerm_network_interface.nic_ls.virtual_machine_id
# }

output "vm_wts_id" {
  value = azurerm_windows_virtual_machine.vm_wts.id
}

output "vm_wts_private_ip_address" {
  value = azurerm_windows_virtual_machine.vm_wts.private_ip_address
}
# output "vm_ls_id" {
#   value = azurerm_linux_virtual_machine.vm_ls.id
# }

# output "vm_ls_private_ip_address" {
#   value = azurerm_linux_virtual_machine.vm_ls.private_ip_address
# }

