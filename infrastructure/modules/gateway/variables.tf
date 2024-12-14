variable "random_id" {
  description = "Random ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
}

variable "location" {
  description = "Region for resources"
  type        = string
  default     = "France Central"
}

variable "subnet_id_app_gateway" {
  description = "Subnet ID for app gateway"
  type        = string 
}

variable "app_service_host" {
  description = "App service host"
  type        = string
}