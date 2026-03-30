resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  resource_group_name           = var.acr_rg_name
  location                      = var.acr_location
  sku                           = var.acr_sku
  admin_enabled                 = true
  public_network_access_enabled = false
  tags                          = var.acr_tags
}

resource "azurerm_private_dns_zone" "acr" {
  name                = var.acr_pvt_dns_name
  resource_group_name = var.acr_rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr" {
  name                  = var.acr_pvt_dns_vlink
  resource_group_name   = var.acr_rg_name
  private_dns_zone_name = var.acr_pvt_dns_name
  virtual_network_id    = var.acr_vnet_id

  depends_on = [ azurerm_private_dns_zone.acr ]
}

resource "azurerm_private_endpoint" "acr" {
  name                = var.acr_pep_name
  location            = var.acr_location
  resource_group_name = var.acr_rg_name
  subnet_id           = var.acr_subnet_id

  private_service_connection {
    name                           = var.acr_psvc_name
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
    is_manual_connection           = false

  }

  private_dns_zone_group {
    name                 = var.acr_pdns_zone_gp
    private_dns_zone_ids = [azurerm_private_dns_zone.acr.id]
  }

  depends_on = [ azurerm_container_registry.acr, azurerm_private_dns_zone.acr ]
}