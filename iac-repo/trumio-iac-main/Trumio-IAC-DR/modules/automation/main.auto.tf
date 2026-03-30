# modules/automation_account/main.tf

resource "azurerm_automation_account" "automation" {
  name                          = var.auto_name
  resource_group_name           = var.auto_rg_name
  location                      = var.auto_location
  sku_name                      = var.auto_sku
  identity {
    type = "SystemAssigned"
  }
  tags                          = var.auto_tags
}

resource "azurerm_role_assignment" "auto_system_identity" {
  scope                = var.auto_scope
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_automation_account.automation.identity[0].principal_id
}

data "local_file" "FrontendCode-backup-cleanup_runbook" {
  filename = "${path.module}/FrontendCode-backup-cleanup.ps1"
}

resource "azurerm_automation_runbook" "FrontendCode-backup-cleanup_runbook" {
  name                    = var.runbook1_name
  location                = var.runbook_location
  resource_group_name     = var.runbook_rg
  automation_account_name = var.auto_name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "FrontendCode-backup-cleanup"
  runbook_type            = "PowerShell"

  content = data.local_file.FrontendCode-backup-cleanup_runbook.content
  depends_on = [ azurerm_automation_account.automation ]
}

resource "azurerm_automation_schedule" "FrontendCode-backup-cleanup_runbook_schedule" {
  name                    = var.schedule1_name
  resource_group_name     = var.runbook_rg
  automation_account_name = var.auto_name
  frequency               = "Day"
  interval                = 1
  description             = "Schedule to delete the FrontendCode-backup"
  timezone                = "Asia/Kolkata"
  depends_on = [ azurerm_automation_account.automation, azurerm_automation_runbook.FrontendCode-backup-cleanup_runbook ]
}

resource "azurerm_automation_job_schedule" "FrontendCode-backup-cleanup_runbook_job" {
  resource_group_name     = var.runbook_rg
  automation_account_name = var.auto_name
  schedule_name           = var.schedule1_name
  runbook_name            = var.runbook1_name
  depends_on = [ azurerm_automation_account.automation, azurerm_automation_schedule.FrontendCode-backup-cleanup_runbook_schedule ]
}

data "local_file" "Trivy-old-scan-cleanup_runbook" {
  filename = "${path.module}/Trivy-old-scan-cleanup.ps1"
}

resource "azurerm_automation_runbook" "Trivy-old-scan-cleanup_runbook" {
  name                    = var.runbook2_name
  location                = var.runbook_location
  resource_group_name     = var.runbook_rg
  automation_account_name = var.auto_name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "Trivy-old-scan-cleanup"
  runbook_type            = "PowerShell"

  content = data.local_file.Trivy-old-scan-cleanup_runbook.content
  depends_on = [ azurerm_automation_account.automation ]
}

resource "azurerm_automation_schedule" "Trivy-old-scan-cleanup_runbook_schedule" {
  name                    = var.schedule2_name
  resource_group_name     = var.runbook_rg
  automation_account_name = var.auto_name
  frequency               = "Day"
  interval                = 1
  description             = "Schedule to delete the Trivy-old-scan"
  timezone                = "Asia/Kolkata"
  depends_on = [ azurerm_automation_account.automation, azurerm_automation_runbook.Trivy-old-scan-cleanup_runbook ]
}

resource "azurerm_automation_job_schedule" "Trivy-old-scan-cleanup_runbook_job" {
  resource_group_name     = var.runbook_rg
  automation_account_name = var.auto_name
  schedule_name           = var.schedule2_name
  runbook_name            = var.runbook2_name
  depends_on = [ azurerm_automation_account.automation, azurerm_automation_schedule.Trivy-old-scan-cleanup_runbook_schedule ]
}

# resource "azurerm_role_assignment" "auto_system_identity" {
#   scope                = var.auto_scope
#   role_definition_name = "Virtual Machine Contributor"
#   principal_id         = azurerm_automation_account.automation.identity[0].principal_id
# }

# data "local_file" "vm_start_runbook" {
#   filename = "${path.module}/vm_start.ps1"
# }

# resource "azurerm_automation_runbook" "vm_start_runbook" {
#   name                    = var.runbook_name
#   location                = var.runbook_location
#   resource_group_name     = var.runbook_rg
#   automation_account_name = var.auto_name
#   log_verbose             = "true"
#   log_progress            = "true"
#   description             = "VM Start Runbook"
#   runbook_type            = "PowerShell"

#   content = data.local_file.vm_start_runbook.content
# }

# resource "azurerm_automation_schedule" "vm_start_runbook_schedule" {
#   name                    = var.schedule_name
#   resource_group_name     = var.runbook_rg
#   automation_account_name = var.auto_name
#   frequency               = "Day"
#   interval                = 1
#   description             = "Schedule to start the VM"
#   timezone                = "Asia/Calcutta"
# }

# resource "azurerm_automation_job_schedule" "vm_start_runbook_job" {
#   resource_group_name     = var.runbook_rg
#   automation_account_name = var.auto_name
#   schedule_name           = var.schedule_name
#   runbook_name            = var.runbook_name
# parameters = {
#     VMNAME = Trumio-Dev-VM
#     RESOURCEGROUPNAME = Trumio-Dev-RG
#     AZURESUBSCRIPTIONID = b983da0b-033c-4c43-b7b2-eb5e4a976343
#     ACTION = Start
#   }
# }