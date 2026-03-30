resource "azurerm_cognitive_account" "textanalytics" {
  name                          = var.ta_name
  location                      = var.ta_location
  resource_group_name           = var.ta_rg_name
  kind                          = "TextAnalytics"
  #custom_subdomain_name         = var.ta_custom_subdomain_name
  sku_name                      = var.ta_sku
  public_network_access_enabled = true
  tags                          = var.ta_tags
     
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

# resource "azurerm_cognitive_deployment" "deployment" {
#   name                 = var.ta_deploy_name
#   cognitive_account_id = azurerm_cognitive_account.textanalytics.id

#   model {
#     format  = "TextAnalytics"
#     name    = var.ta_model_name
#     version = var.ta_model_version
#   }

#   scale {
#     type = "Standard"
#   }
# }