resource "azurerm_service_plan" "service_plan_project" {
  name                = "shop-service-plan-${var.random_id}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"
}
resource "azurerm_linux_web_app" "app_service_project" {
  name                = "shop-app-service-${var.random_id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id = azurerm_service_plan.service_plan_project.id
  public_network_access_enabled = true
  virtual_network_subnet_id = var.subnet_id_app_service

  site_config {
    application_stack {
      docker_registry_url = "https://ghcr.io"
      docker_image_name   = var.docker_image_name
      docker_registry_username = var.docker_registry_username
      docker_registry_password = var.docker_registry_password
    }
  }

  app_settings = {
    DATABASE_HOST = var.database_host
    DATABASE_PORT = "5432"
    DATABASE_NAME = "shop"
    DATABASE_USER = var.username_db
    DATABASE_PASSWORD = var.password_db
    PORT = "5000"
  }

  identity {
    type = "SystemAssigned"
  }

}