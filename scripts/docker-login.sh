#!/usr/bin/env sh

# Check if .env exists and source it
if [ -f .env ]; then
    echo "Sourcing from .env file"
    source .env
else
    echo "Error: .env file not found!"
    exit 1
fi

# Exit if docker login fails
echo "$HARBOR_TOKEN" | docker login -u "${HARBOR_USERNAME}" --password-stdin "$HARBOR_REGISTRY" || exit 1
