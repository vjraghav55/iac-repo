resource "azurerm_key_vault" "keyvault" {
  name                        = var.keyvault_name
  location                    = var.keyvault_location
  resource_group_name         = var.keyvault_resource_group_name
  sku_name                    = var.keyvault_sku_name
  tenant_id                   = var.tenant_id
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = var.soft_delete_retention_days

 dynamic "access_policy" {
    for_each = var.object_ids
    content {
      tenant_id = var.tenant_id
      object_id = access_policy.value

# Permissions for each Object ID
      secret_permissions = [
        "Get",
        "List",
        "Set",
        "Purge",
        "Delete",
        "Recover",
        "Restore"
      ]

      key_permissions = [
        "Encrypt",
        "Decrypt",
        "Sign",
        "Verify"
      ]

      certificate_permissions = [
        "Get",
        "List",
        "Delete",
        "Create",
        "Import",
        "Purge",
        "Recover",
        "Restore",
        "Update"
      ]
    }
  }
}

resource "azurerm_key_vault_secret" "secret" {
  for_each          = var.secrets
  name              = each.key
  value             = each.value
  key_vault_id      = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_certificate" "certificate" {
  name         = "trumio-pfx"
  key_vault_id = azurerm_key_vault.keyvault.id

  certificate {
    contents = filebase64("trumio_ai.pfx")
    password = "trumio@sys"
  }
}