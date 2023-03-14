resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location

  tags = {
    Project        = "Automation Project – Assignment 1"
    Name           = "Ganesh.Thampi"
    ExpirationDate = "2023-06-30"
    Environment    = "Lab"
  }
}
