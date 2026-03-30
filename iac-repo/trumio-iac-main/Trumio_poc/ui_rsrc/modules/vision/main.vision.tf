resource "azurerm_cognitive_account" "computervision" {
  name                          = var.cv_name
  location                      = var.cv_location
  resource_group_name           = var.cv_rg_name
  kind                          = "ComputerVision"
  #custom_subdomain_name         = var.cv_custom_subdomain_name
  sku_name                      = var.cv_sku
  public_network_access_enabled = true
  tags                          = var.cv_tags
     
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

# resource "azurerm_cognitive_deployment" "visiondeployment" {
#   name                 = var.vision_deploy_name
#   cognitive_account_id = azurerm_cognitive_account.computervision.id

#   model {
#     format  = "ComputerVision"
#     name    = var.vision_model_name
#     version = var.vision_model_version
#   }

#   scale {
#     type = "Standard"
#   }
# }