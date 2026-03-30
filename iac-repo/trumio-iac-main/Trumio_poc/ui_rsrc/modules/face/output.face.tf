output "cognitive_account_name" {
  value = azurerm_cognitive_account.faceapi.name
}

output "cognitive_account_id" {
  value = azurerm_cognitive_account.faceapi.id
}

# output "deployments" {
#   value  = keys(azurerm_cognitive_deployment.facedeployment)
# }