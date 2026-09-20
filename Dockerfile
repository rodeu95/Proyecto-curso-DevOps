# ---------- Stage 1: Build ----------
FROM node:22-alpine AS build

WORKDIR /app

COPY package.json .
COPY build.js .
COPY src ./src

RUN npm run build


# ---------- Stage 2: Production ----------
FROM nginx:alpine

COPY --from=build /app/dist/ /usr/share/nginx/html/

EXPOSE 80