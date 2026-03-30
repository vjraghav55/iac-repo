# Resource group name and location is defined in variable file
# Given a local name tr-rg, The name is used to refer to this resource from 
# elsewhere in the same Terraform module but has no significance outside

resource "azurerm_resource_group" "rg" {
    name      = var.rg_name
    location  = var.rg_location
    tags      = var.rg_tags
}