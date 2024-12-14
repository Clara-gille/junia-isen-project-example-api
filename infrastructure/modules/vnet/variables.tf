variable "resource_group_name" {
  description = "Nom du groupe de ressources."
  type        = string
}

variable "location" {
  description = "Région Azure où déployer les ressources."
  type        = string
}

variable "random_id" {
  description = "Identifiant aléatoire pour les ressources."
  type        = string
}

variable "subnet_id_app_service" {
  description = "Subnet ID for the App Service"
  type        = string
}

variable "subnet_id_db" {
  description = "ID of the subnet for the database"
  type        = string
}