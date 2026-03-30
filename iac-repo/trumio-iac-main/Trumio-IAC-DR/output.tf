output "primary_web_host" {
  value = { for key, storage_account in module.storage_account : key => storage_account.primary_web_host }
}

