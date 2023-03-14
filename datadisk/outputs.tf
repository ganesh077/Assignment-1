output "managed_disk_ids" {
  description = "The IDs of the managed disks that were created."
  value       = azurerm_managed_disk.datadisk.*.id
}

output "virtual_machine_data_disk_attachments" {
  description = "The data disk attachments for each virtual machine."
  value       = {
    for vm_name in var.vm_names : vm_name => [
      for i in range(var.disk_count) : element(azurerm_managed_disk.datadisk.*.id, index(azurerm_virtual_machine_data_disk_attachment.datadisk.*.managed_disk_id, azurerm_managed_disk.datadisk[i].id, -1))
    ]
  }
}

output "vm_ids" {
  description = "The IDs of the virtual machines."
  value       = [azurerm_virtual_machine.vm1.id, azurerm_virtual_machine.vm2.id, azurerm_virtual_machine.windows.id]
}
