resource "azurerm_eventgrid_topic" "evgtopic" {
  name                = var.evgtopic_name
  location            = var.evgtopic_location
  resource_group_name = var.evgtopic_rg
}

