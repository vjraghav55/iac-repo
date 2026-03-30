
resource "azurerm_storage_account" "storage" {
  name                            = var.sa_name
  resource_group_name             = var.sa_rg_name
  location                        = var.sa_location
  account_tier                    = var.sa_account_tier
  account_kind                    = var.sa_account_kind
  access_tier                     = var.sa_access_tier
  account_replication_type        = var.sa_account_replication_type
  public_network_access_enabled   = true
  min_tls_version                 = "TLS1_2"
  tags                            = var.sa_tags
  blob_properties {
    delete_retention_policy {
        days = 7
      }
    container_delete_retention_policy {
        days = 7
      }
  }
}

resource "azurerm_storage_container" "containers" {
  for_each                 = var.containers
  name                     = each.value["name"]
  container_access_type    = each.value["container_access_type"]
  storage_account_name     = azurerm_storage_account.storage.name
  depends_on               = [ azurerm_storage_account.storage ]
}
