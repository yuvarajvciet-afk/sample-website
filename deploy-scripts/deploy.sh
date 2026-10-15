#!/bin/bash

set -Eeuo pipefail

APP_DIR="/home/ubuntu/sample-website"
IMAGE_NAME="sample-website"
CONTAINER_NAME="sample-website"

cd "$APP_DIR"

echo "Building Docker image..."

sudo docker build -t "${IMAGE_NAME}:latest" .

echo "Removing old container if present..."

sudo docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "Starting new container..."

sudo docker run -d 
--name "$CONTAINER_NAME" 
--restart unless-stopped 
-p 80:80 
"${IMAGE_NAME}:latest"

echo "Deployment completed!"

sudo docker ps --filter "name=$CONTAINER_NAME"

sudo docker logs --tail 30 "$CONTAINER_NAME"
