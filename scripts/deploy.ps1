
$ErrorActionPreference = "Stop"

$image = "ghcr.io/rodeu95/proyecto-curso-devops:latest"
$deployment = "devops-dashboard"

Write-Host "1. Descargando la última imagen de GHCR..."
docker pull $image
if ($LASTEXITCODE -ne 0) {
    throw "No se pudo descargar la imagen."
}

Write-Host "2. Reiniciando el Deployment de Kubernetes..."
kubectl rollout restart "deployment/$deployment"
if ($LASTEXITCODE -ne 0) {
    throw "No se pudo reiniciar el Deployment."
}

Write-Host "3. Esperando que finalice el despliegue..."
kubectl rollout status "deployment/$deployment" --timeout=120s
if ($LASTEXITCODE -ne 0) {
    throw "El despliegue no terminó correctamente."
}

Write-Host "4. Verificando las réplicas..."
kubectl get deployment $deployment
kubectl get pods

Write-Host "Despliegue finalizado."
Write-Host "Dashboard: http://localhost:30080"
