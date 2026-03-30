output "appgw_id" {
  description = "ID of the created application gateway."
  value       = azurerm_application_gateway.appgw.id
}
