output "app_service_host" {
  value = azurerm_linux_web_app.app_service_project.default_hostname
}