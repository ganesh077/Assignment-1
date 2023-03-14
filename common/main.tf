resource "azurerm_log_analytics_workspace" "law" {
  name                = var.law_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = var.rsv_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

resource "azurerm_storage_account" "sa" {
  name                     = var.sa_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    Project        = "Automation Project – Assignment 1"
    Name           = "Ganesh.Thampi"
    ExpirationDate = "2023-06-30"
    Environment    = "Lab"
  }
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "N01469295-law"
  location            = var.location
  resource_group_name = var.resource_group_name
    sku                 = "PerGB2018"
  retention_in_days = 30

  tags = {
    Project        = "Automation Project – Assignment 1"
    Name           = "Ganesh.Thampi"
    ExpirationDate = "2023-06-30"
    Environment    = "Lab"
  }
}

resource "azurerm_log_analytics_linked_storage_account" "law_sa" {
  data_source_type      = "CustomLogs"
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  storage_account_ids   = [azurerm_storage_account.sa.id]
}

