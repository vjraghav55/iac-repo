output "user_identity_principal_id" {
  value = azurerm_user_assigned_identity.appgw_identity.principal_id
}

output "user_identity_client_id" {
  value = azurerm_user_assigned_identity.appgw_identity.client_id
}

output "user_id" {
  value = azurerm_user_assigned_identity.appgw_identity.id
}