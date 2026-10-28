
variable "container_name" {
  description = "Nombre del contenedor del dashboard"
  type        = string
  default     = "devops-dashboard-terraform"
}

variable "app_port" {
  description = "Puerto local donde estará disponible el dashboard"
  type        = number
  default     = 8081
}
