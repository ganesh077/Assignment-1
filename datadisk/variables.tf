variable "location" {
  description = "The location where the managed disks will be created."
}

variable "resource_group_name" {
  description = "The name of the resource group where the managed disks will be created."
}

variable "vm_names" {
  description = "A list of virtual machine names to attach the data disks to."
  type        = list(string)
}

variable "disk_count" {
  description = "The number of data disks to create and attach to each virtual machine."
  default     = 3
}

variable "disk_size_gb" {
  description = "The size of each data disk in GB."
  default     = 10
}

variable "tags" {
  description = "A mapping of tags to assign to the managed disks."
  type        = map(string)
  default     = {
    Project          = "Automation Project - Assignment 1"
    Environment      = "Lab"
    ExpirationDate   = "2023-06-30"
  }
}

variable "vm_ids" {
  description = "A list of virtual machine IDs to attach the data disks to."
  type        = list(string)
}