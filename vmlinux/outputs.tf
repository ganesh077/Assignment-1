output "vm_hostnames" {
description = "The hostnames of the VMs."
value = [for i in range(var.vm_count) : azurerm_virtual_machine.vm[i].name]
}

output "vm_domain_names" {
  value = [for i in range(var.vm_count) : "${azurerm_virtual_machine.vm[i].name}.${var.dns_suffix}"]
}


output "vm_private_ips" {
description = "The private IP addresses of the VMs."
value = [for i in range(var.vm_count) : azurerm_network_interface.nic[i].private_ip_address]
}

output "vm_public_ips" {
description = "The public IP addresses of the VMs."
value = [for i in range(var.vm_count) : azurerm_public_ip.public_ip[i].ip_address]
}