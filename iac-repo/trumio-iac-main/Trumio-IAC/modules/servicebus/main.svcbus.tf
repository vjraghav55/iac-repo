resource "azurerm_servicebus_namespace" "svcbus" {
  name                = var.svcbus_name
  location            = var.svcbus_location
  resource_group_name = var.svcbus_rg
  sku                 = "Standard"
}

resource "azurerm_servicebus_topic" "svcbus_topic" {
  name         = "var.svcbus_topic"
  namespace_id = azurerm_servicebus_namespace.svcbus.id
  enable_partitioning = false
}