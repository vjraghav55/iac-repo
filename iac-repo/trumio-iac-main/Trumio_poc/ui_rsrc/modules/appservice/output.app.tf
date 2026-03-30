output "app_service_plan_id" {
  value       = azurerm_service_plan.appserviceplan.id
}

output "web_app_id" {
  value       = azurerm_linux_web_app.webapp.id
}

# output "app_service_source_control_id" {
#   value       = azurerm_app_service_source_control.sourcecontrol.id
# }
