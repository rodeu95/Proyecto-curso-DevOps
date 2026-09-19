# ---------- Stage 1: Build ----------
FROM node:22-alpine AS build

WORKDIR /app

COPY src/ .

# ---------- Stage 2: Production ----------
FROM nginx:alpine

COPY --from=build /app/ /usr/share/nginx/html/

EXPOSE 80