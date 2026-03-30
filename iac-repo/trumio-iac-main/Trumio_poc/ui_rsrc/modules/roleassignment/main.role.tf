resource "azurerm_role_assignment" "trumio" {
  #for_each              = var.principal_ids
  scope                 = var.scope
  role_definition_name  = var.role_definition
  #principal_id          = each.value
  principal_id          = var.principal_id
}
