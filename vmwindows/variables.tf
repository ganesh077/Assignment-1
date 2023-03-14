variable "location" {
  type        = string
}

variable "resource_group_name" {
  type        = string
}

variable "subnet_id" {
  type        = string
}

variable "vm_size" {
  type        = string
}

variable "admin_username" {
  type        = string
}

variable "admin_password" {
  type        = string
}

variable "domain_name_label" {
  type        = string
}

variable "dns_zone" {
  type        = string
}

variable "tags" {
  type        = map(string)
}

variable "resource_prefix" {
  type        = string
}