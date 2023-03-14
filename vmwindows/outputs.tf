output "vmwindows_hostname" {
  value = azurerm_virtual_machine.vmwindows.name
}

output "vmwindows_domain_name" {
  value = "${azurerm_virtual_machine.vmwindows.name}.${var.domain_name_label}.${var.dns_zone}"
}

output "vmwindows_private_ip_address" {
  value = azurerm_network_interface.vmwindows_nic.private_ip_address
}

output "vmwindows_public_ip_address" {
  value = azurerm_public_ip.vmwindows_public_ip.ip_address
}
