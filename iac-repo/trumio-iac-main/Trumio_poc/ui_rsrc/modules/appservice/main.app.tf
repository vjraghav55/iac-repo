

# Linux App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = var.asp_name
  location            = var.asp_rg_location
  resource_group_name = var.asp_rg_name
  os_type             = "Linux"
  sku_name            = var.asp_sku
}

# Web App
resource "azurerm_linux_web_app" "webapp" {
  name                  = var.webapp_name
  location              = var.webapp_rg_location
  resource_group_name   = var.webapp_rg_name
  service_plan_id       = azurerm_service_plan.appserviceplan.id
  https_only            = true
  

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
  }
  site_config { 
    minimum_tls_version = "1.2"
    app_command_line    = "gunicorn --bind=0.0.0.0 --timeout 600 application:application"
    ftps_state          = "FtpsOnly"
    always_on           = true
    application_stack {
      python_version = "3.12"
    }
    }

  logs {
    application_logs {
      file_system_level = "Information"
    }
    detailed_error_messages = false
    failed_request_tracing = false
    http_logs {
      file_system {
        retention_in_days = 3
        retention_in_mb = 35
      }
      }
    }
  }
 

#  Code deploy from GitHub repo
# resource "azurerm_app_service_source_control" "sourcecontrol" {
#  app_id   = azurerm_linux_web_app.webapp.id
#   repo_url = var.repo_url
#   branch   = var.repo_branch
#   depends_on  = [ azurerm_linux_web_app.webapp ]

#   timeouts {
#    create = "30m"
#     update = "30m"
#     delete = "30m"  
#   }
# }
# resource "azurerm_source_control_token" "source_token" {
#  type         = "GitHub"
#   token        = var.token
# }
