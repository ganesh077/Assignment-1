variable "vm_count" {
description = "The number of virtual machines to create."
type = number
default = 2
}

variable "subnet_id" {
description = "The ID of the subnet to associate the virtual machines with."
type = string
}

variable "location" {
description = "The location of the resource group."
type = string
}

variable "resource_group_name" {
description = "The name of the resource group."
type = string
}


variable "admin_username" {
description = "The administrator username for the virtual machines."
type = string
}

variable "custom_data" {
description = "Custom data to be passed to the virtual machines."
type = string
}

variable "ssh_key" {
description = "The SSH public key to be added to the virtual machines."
type = string
}

variable "ssh_private_key" {
description = "The SSH private key to use to connect to the virtual machines."
type = string
}

variable "log_analytics_workspace_id" {
description = "The ID of the Log Analytics workspace."
type = string
}

variable "log_analytics_workspace_resource_id" {
description = "The resource ID of the Log Analytics workspace."
type = string
}

variable "dns_suffix" {
  description = "The DNS suffix to use for the virtual machine hostnames."
  default = "n01469295.com"
}