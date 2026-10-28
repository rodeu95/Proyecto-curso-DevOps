
output "dashboard_url" {
  description = "URL local del dashboard"
  value       = "http://localhost:${var.app_port}"
}

output "docker_network_name" {
  description = "Red Docker creada por Terraform"
  value       = docker_network.dashboard_network.name
}

output "container_name" {
  description = "Nombre del contenedor creado"
  value       = docker_container.dashboard.name
}
