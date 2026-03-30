resource "azurerm_storage_account" "storage" {
  name                            = var.sa_name
  resource_group_name             = var.sa_rg_name
  location                        = var.sa_location
  account_tier                    = var.sa_account_tier
  account_kind                    = var.sa_account_kind
  access_tier                     = var.sa_access_tier
  account_replication_type        = var.sa_account_replication_type
 # public_network_access_enabled   = false
  min_tls_version                 = "TLS1_2"
  tags                            = var.sa_tags
  blob_properties {
    delete_retention_policy {
        days = 7
      }
    container_delete_retention_policy {
        days = 7
    }
    dynamic "cors_rule" {
      for_each = var.cors_rule
      content {
        allowed_origins     =  lookup(cors_rule.value, "allowed_origins", null)
        allowed_methods     =  lookup(cors_rule.value, "allowed_methods", null)
        allowed_headers     =  lookup(cors_rule.value, "allowed_headers", null)
        exposed_headers     =  lookup(cors_rule.value, "exposed_headers", null)
        max_age_in_seconds  =  lookup(cors_rule.value, "max_age_in_seconds", null)
      }
    }
  }
  dynamic "static_website" {
    for_each = var.static_website_config 
    content {
      index_document     = lookup(static_website.value, "index_document", null)
      error_404_document = lookup(static_website.value, "error_404_document", null)
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

resource "azurerm_security_center_storage_defender" "example" {
  storage_account_id = azurerm_storage_account.storage.id
  
  override_subscription_settings_enabled      = false   # Optional
  sensitive_data_discovery_enabled            = true   # Optional
  malware_scanning_on_upload_enabled          = true
  malware_scanning_on_upload_cap_gb_per_month = 10
}