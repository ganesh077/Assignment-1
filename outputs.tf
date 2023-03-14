output "resource_group_name" {
  value = module.rgroup.rg_name
}

output "virtual_network_name" {
  value = module.network.vnet_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "log_analytics_workspace_name" {
  value = module.common.law_name
}

output "recovery_services_vault_name" {
  value = module.common.rsv_name
}

output "storage_account_name" {
  value = module.common.sa_name
}

output "vm_hostnames" {
  value = module.vmlinux.vm_hostnames
}

output "vm_private_ips" {
  value = module.vmlinux.vm_private_ips
}

output "vm_public_ips" {
  value = module.vmlinux.vm_public_ips
}

output "vm_domain_names" {
  value = module.vmlinux.vm_domain_names
}

output "vmwindows_hostname" {
  value = module.vmwindows.vmwindows_hostname
}

output "vmwindows_domain_name" {
  value = module.vmwindows.vmwindows_domain_name
}

output "vmwindows_private_ip_address" {
  value = module.vmwindows.vmwindows_private_ip_address
}

output "vmwindows_public_ip_address" {
  value = module.vmwindows.vmwindows_public_ip_address
}

output "datadisk_managed_disk_ids" {
  description = "The IDs of the managed disks that were created for the data disks."
  value       = module.datadisk.managed_disk_ids
}

output "datadisk_vm_data_disk_attachments" {
  description = "The data disk attachments for each virtual machine."
  value       = module.datadisk.virtual_machine_data_disk_attachments
}
