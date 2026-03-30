resource "azurerm_cognitive_account" "faceapi" {
  name                          = var.fa_name
  location                      = var.fa_location
  resource_group_name           = var.fa_rg_name
  kind                          = "Face"
  #custom_subdomain_name         = var.fa_custom_subdomain_name
  sku_name                      = var.fa_sku
  public_network_access_enabled = true
  tags                          = var.fa_tags
     
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

# resource "azurerm_cognitive_deployment" "facedeployment" {
#   name                 = var.fa_deploy_name
#   cognitive_account_id = azurerm_cognitive_account.faceapi.id

#   model {
#     format  = "Face"
#     name    = var.face_model_name
#     version = var.face_model_version
#   }

#   scale {
#     type = "Standard"
#   }
# }