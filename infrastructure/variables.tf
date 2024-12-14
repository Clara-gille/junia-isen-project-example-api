variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "2d8d3767-6ea6-4e1a-a6b1-606e793fca7d"
}

variable "location" {
  description = "Location of the resource group"
  type        = string
  default     = "francecentral"
}

variable "username_db" {
  description = "Username for the database"
  type        = string
}

variable "password_db" {
  description = "Password for the database"
  type        = string
  sensitive = true
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