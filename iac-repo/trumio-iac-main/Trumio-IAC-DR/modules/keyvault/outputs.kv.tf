# modules/keyvault/output.tf

output "keyvault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.keyvault.id
}

output "keyvault_uri" {
  description = "The URI of the Key Vault."
  value       = azurerm_key_vault.keyvault.vault_uri
}

# output "keyvault_secret_id" {
#   description = "The URI of the Key Vault."
#   value       = azurerm_key_vault_certificate.certificate.secret_id
# }
