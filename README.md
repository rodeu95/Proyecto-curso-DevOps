# Proyecto Final DevOps — Dashboard Web

## Descripción

Este proyecto consiste en una aplicación web estática desarrollada con HTML, CSS y JavaScript, empaquetada con Docker y desplegada localmente con Kubernetes.

El objetivo es aplicar conceptos y herramientas de DevOps para automatizar la construcción, validación, publicación y despliegue de la aplicación.

## Tecnologías utilizadas

- **HTML, CSS y JavaScript:** desarrollo del dashboard.
- **Docker:** contenerización de la aplicación.
- **Docker multi-stage build:** separación de la etapa de construcción de la imagen de producción.
- **Docker Compose:** ejecución local de la aplicación.
- **Git y GitHub:** control de versiones y alojamiento del código.
- **GitHub Actions:** automatización de CI/CD.
- **GitHub Container Registry (GHCR):** publicación de la imagen Docker.
- **CodeQL:** análisis estático de seguridad (SAST).
- **OWASP ZAP:** análisis dinámico de seguridad (DAST).
- **Terraform:** gestión declarativa de recursos Docker.
- **Kubernetes:** despliegue y administración de réplicas.
- **PowerShell:** automatización del despliegue.

## Estructura del proyecto

```text
.
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── dast.yml
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── nginx/
│   └── default.conf
├── scripts/
│   └── deploy.ps1
├── src/
│   ├── index.html
│   ├── style.css
│   └── app.js
├── terraform/
│   ├── versions.tf
│   ├── variables.tf
│   ├── main.tf
│   └── outputs.tf
├── Dockerfile
├── compose.yaml
├── package.json
└── build.js
```

## Ejecución local con Docker Compose

Requisitos: Docker Desktop y Docker Compose.

Desde la raíz del repositorio, ejecutar:

docker compose up --build -d


Abrir la aplicación en:

http://localhost:8080

Para detener los servicios:

docker compose down


## Integración continua y seguridad

El workflow ci.yml automatiza tareas de validación y construcción de la aplicación. Incluye el análisis de código con CodeQL, la ejecución del proceso de build y la construcción y publicación de la imagen Docker en GitHub Container Registry.

El workflow dast.yml ejecuta OWASP ZAP Baseline contra la aplicación levantada localmente en el entorno de GitHub Actions y genera un reporte de seguridad como artefacto de la ejecución.

La imagen publicada está disponible en:

ghcr.io/rodeu95/proyecto-curso-devops:latest

## Infraestructura con Terraform

Terraform administra recursos Docker locales: una red y un contenedor para la aplicación.

Desde la carpeta "terraform", ejecutar:

terraform init
terraform validate
terraform plan
terraform apply


Confirmar la aplicación de los cambios cuando Terraform lo solicite.

La URL configurada para este despliegue es:

http://localhost:8081

Para eliminar los recursos creados por Terraform:

terraform destroy


> Antes de ejecutar Terraform por primera vez, verificar que la imagen local "devops-dashboard:terraform" esté disponible. El estado de Terraform se mantiene localmente y no debe subirse al repositorio.

## Despliegue en Kubernetes

El proyecto incluye un Deployment con dos réplicas y un Service de tipo NodePort.

Requisitos: Docker Desktop con Kubernetes habilitado y kubectl configurado para acceder al cluster local.

Aplicar los manifiestos desde la raíz del repositorio:

kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml


Verificar el despliegue:

kubectl get deployments
kubectl get pods
kubectl get services

Acceder al dashboard en:

http://localhost:30080

Kubernetes mantiene el número deseado de réplicas y puede crear un nuevo Pod cuando uno de ellos deja de estar disponible.

## Automatización del despliegue

El script "scripts/deploy.ps1" descarga la imagen publicada en GHCR, reinicia el Deployment y espera a que termine el despliegue.

Desde la raíz del proyecto, ejecutar:

.\scripts\deploy.ps1


Este script automatiza el despliegue manual en el cluster local. No representa un despliegue automático desde GitHub Actions hacia Kubernetes.

## Conclusión

El proyecto integra herramientas de desarrollo, infraestructura como código, contenerización, orquestación y seguridad dentro de un flujo de trabajo DevOps.

Se implementaron procesos automatizados de construcción y análisis, publicación de imágenes, despliegue en Kubernetes y administración de recursos Docker con Terraform.
