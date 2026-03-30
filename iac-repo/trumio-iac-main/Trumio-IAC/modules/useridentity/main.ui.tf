resource "azurerm_user_assigned_identity" "appgw_identity" {
  name                = var.user_identity_appgw_name
  location            = var.user_identity_appgw_location
  resource_group_name = var.user_identity_appgw_rg_name
}
