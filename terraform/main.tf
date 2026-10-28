
resource "docker_network" "dashboard_network" {
  name = "devops-dashboard-network"
}

resource "docker_image" "dashboard" {
  name         = "devops-dashboard:terraform"
  keep_locally = true
}

resource "docker_container" "dashboard" {
  name  = var.container_name
  image = docker_image.dashboard.image_id

  ports {
    internal = 80
    external = var.app_port
  }

  networks_advanced {
    name = docker_network.dashboard_network.name
  }
}
