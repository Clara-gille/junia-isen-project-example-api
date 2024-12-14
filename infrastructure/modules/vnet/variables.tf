variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure deployment region for resources"
  type        = string
}

variable "random_id" {
  description = "Randomly generated ID for resources"
  type        = string
}

variable "subnet_id_app_service" {
  description = "Subnet ID for the Webapp"
  type        = string
}

variable "subnet_id_db" {
  description = "Subnet ID for the database"
  type        = string
}