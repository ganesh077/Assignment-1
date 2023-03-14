output "law_name" {
  description = "The name of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.law.name
}

output "rsv_name" {
  description = "The name of the Recovery Services vault."
  value       = azurerm_recovery_services_vault.rsv.name
}

output "sa_name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.sa.name
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.log_analytics_workspace.id
}


output "log_analytics_workspace_resource_id" {
  value = azurerm_log_analytics_workspace.log_analytics_workspace.id
}
