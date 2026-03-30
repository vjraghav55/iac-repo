resource "azurerm_cognitive_account" "openai" {
  name                          = var.opi_name
  location                      = var.opi_location
  resource_group_name           = var.opi_rg_name
  kind                          = "OpenAI"
  #custom_subdomain_name         = var.opi_custom_subdomain_name
  sku_name                      = var.opi_sku
  public_network_access_enabled = true
  tags                          = var.opi_tags
     
  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# resource "azurerm_cognitive_deployment" "deployment" {
#   for_each             = {for deployment in var.deployments: deployment.name => deployment}

#   name                 = each.key
#   cognitive_account_id = azurerm_cognitive_account.openai.id

#   model {
#     format  = "OpenAI"
#     name    = each.value.model.name
#     version = each.value.model.version
#   }

#   scale {
#     type = "Standard"
#   }
# }

resource "azurerm_cognitive_deployment" "deployment" {
  name                 = var.opi_deploy_name
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = var.model_name
    version = var.model_version
  }

  scale {
    type = "Standard"
  }
}