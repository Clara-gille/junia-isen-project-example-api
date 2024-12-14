provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "shop-app-rg"
  location = "France Central"
}

resource "azurerm_app_service_plan" "example" {
  name                = "shop-app-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "shop-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
}
