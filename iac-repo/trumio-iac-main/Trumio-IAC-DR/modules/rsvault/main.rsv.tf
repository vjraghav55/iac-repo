resource "azurerm_recovery_services_vault" "rsv" {
  name                = var.rsv_name
  location            = var.rsv_location
  resource_group_name = var.rsv_rg
  sku                 = var.rsv_sku
}

# resource "azurerm_backup_policy_vm" "rsvbackup_policy" {
#   name                = var.backup_policy_vm_name
#   resource_group_name = var.backup_policy_vm_rg
#   recovery_vault_name = azurerm_recovery_services_vault.rsv.name

#   backup {
#     frequency = "Daily"
#     time      = "10:00"
#   }
#   retention_daily {
#     count = 10
#   }
# }

# resource "azurerm_backup_protected_vm" "rsvbackup_protected" {
#   resource_group_name = var.backup_protected_vm_rg
#   recovery_vault_name = var.backup_protected_vm_rsvname
#   source_vm_id        = var.backup_protected_source_vm_id
#   backup_policy_id    = azurerm_backup_policy_vm.rsvbackup_policy.id
# }