output "cognitive_account_name" {
  value = azurerm_cognitive_account.computervision.name
}

output "cognitive_account_id" {
  value = azurerm_cognitive_account.computervision.id
}

# output "deployments" {
#   value  = keys(azurerm_cognitive_deployment.visiondeployment)
# }
