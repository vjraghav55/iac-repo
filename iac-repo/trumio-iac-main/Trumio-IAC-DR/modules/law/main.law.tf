resource "azurerm_log_analytics_workspace" "logworkspace" {
  name                = var.logworkspace_name
  location            = var.logworkspace_location
  resource_group_name = var.logworkspace_rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}