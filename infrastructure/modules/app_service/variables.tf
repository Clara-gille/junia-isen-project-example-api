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

variable "username_db" {
  description = "Username for the database"
  type        = string
}

variable "password_db" {
  description = "Password for the database"
  type        = string
}

variable "database_name" {
  description = "Name of the database"
  type        = string 
}

variable "database_host" {
  description = "Host of the database"
  type        = string
}
variable "subnet_id_app_service" {
  description = "ID of the subnet for the app service"
  type        = string
}

variable "docker_image_name" {
  description = "Name of the docker image"
  type        = string
}

variable "docker_registry_username" {
  description = "Username for the docker registry"
  type        = string
}

variable "docker_registry_password" {
  description = "Password for the docker registry"
  type        = string
  sensitive   = true
}