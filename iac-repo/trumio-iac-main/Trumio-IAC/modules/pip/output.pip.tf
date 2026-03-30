output "app_gw_pip_address" {
  description = "Public IP address of the Application Gateway"
  value       = azurerm_public_ip.app_gw_pip.ip_address
}

output "public_name" {
  description = "Public IP address name of the Application Gateway"
  value       = azurerm_public_ip.app_gw_pip.name
}

output "public_id" {
  description = "Public IP address id of the Application Gateway"
  value       = azurerm_public_ip.app_gw_pip.id
}