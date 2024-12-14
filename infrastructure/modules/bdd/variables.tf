variable "username_db" {
  description = "Username for the database"
  type        = string
}

variable "password_db" {
  description = "Password for the database"
  type        = string
}

variable "location" {
  description = "Region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
}

variable "random_id" {
  description = "Random ID"
  type        = string
}

variable "vnet_id" {
  description = "ID of the virtual network"
  type        = string
}

variable "subnet_id_db" {
  description = "ID of the subnet for the database"
  type        = string
}