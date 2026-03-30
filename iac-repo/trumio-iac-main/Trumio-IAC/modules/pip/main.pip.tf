# Public IP for Application Gateway
resource "azurerm_public_ip" "app_gw_pip" {
  name                          = var.app_gw_pip_name
  location                      = var.app_gw_pip_location
  resource_group_name           = var.app_gw_pip_rg_name
  allocation_method             = "Static"
  sku                           = "Standard"
  tags                          = var.app_gw_pip_tags
}

