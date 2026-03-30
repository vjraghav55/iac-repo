output "cognitive_account_name" {
  value = azurerm_cognitive_account.textanalytics.name
}

output "cognitive_account_id" {
  value = azurerm_cognitive_account.textanalytics.id
}

# output "deployments" {
#   value  = keys(azurerm_cognitive_deployment.deployment)
# }