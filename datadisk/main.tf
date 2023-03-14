resource "azurerm_managed_disk" "datadisk" {
  count               = var.disk_count * length(var.vm_names)
  name                = "${var.resource_group_name}-datadisk-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  storage_account_type = "Standard_LRS"
  disk_size_gb        = var.disk_size_gb
  create_option        = "Empty"
  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk" {
  count = var.disk_count * length(var.vm_names)

  managed_disk_id      = element(azurerm_managed_disk.datadisk.*.id, count.index)
  virtual_machine_id   = element(var.vm_ids, count.index / var.disk_count)
  lun                  = count.index % var.disk_count
}
