output "cognitive_account_name" {
  value = azurerm_cognitive_account.openai.name
}

output "cognitive_account_id" {
  value = azurerm_cognitive_account.openai.id
}

output "deployments" {
  value  = keys(azurerm_cognitive_deployment.deployment)
}