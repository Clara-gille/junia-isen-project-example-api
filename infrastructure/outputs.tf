output "random_id_value" {
  value = random_id.random.hex
}

output "subnet_id_app_service" {
  value = module.vnet.subnet_id_app_service
}