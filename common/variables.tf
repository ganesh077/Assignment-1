variable "law_name" {
  description = "The name of the Log Analytics workspace."
  type        = string
}

variable "rsv_name" {
  description = "The name of the Recovery Services vault."
  type        = string
}

variable "sa_name" {
  description = "The name of the storage account."
  type        = string
}

variable "location" {
  description = "The location of the resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "key_name" {
  type    = string
  default = "mykey"
}
