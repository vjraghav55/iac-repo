resource "azurerm_public_ip" "pip" {
  name                = var.vnet_gw_pip_name
  location            = var.vnet_gw_pip_location
  resource_group_name = var.vnet_gw_pip_rg
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "networkgw" {
  name                = var.vnet_gw_name
  location            = var.vnet_gw_location
  resource_group_name = var.vnet_gw_rg
  type                = var.vnet_gw_type
  vpn_type            = var.vnet_gw_vpn_type
  active_active       = false
  enable_bgp          = false
  sku                 = var.vnet_gw_sku

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.vnet_gw_subnet_id
  }

}