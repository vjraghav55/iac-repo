resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    location            = var.vnet_location
    resource_group_name = var.vnet_rg_name
    address_space       = var.vnet_address_prefix
    tags                = var.vnet_tags
}

resource "azurerm_subnet" "subnets" {
    for_each              = var.subnets
    name                  = each.value["name"]
    address_prefixes      = each.value["address_prefix"]
    resource_group_name   = var.vnet_rg_name
    virtual_network_name  = var.vnet_name
    depends_on            = [ azurerm_virtual_network.vnet ]

    dynamic "delegation" {
        for_each = each.key == "subnet6" ? [true] : []
        content {
            name = "fs"

            service_delegation {
                name    = "Microsoft.DBforMySQL/flexibleServers"
                actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
            }
        }
    }

    # Service endpoints for the subnets
    service_endpoints = each.key == "subnet6" ? ["Microsoft.Storage"] : []
}
