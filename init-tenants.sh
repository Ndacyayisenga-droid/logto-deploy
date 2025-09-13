#!/bin/sh
set -e

# Wait for Postgres to be ready
echo "Waiting for Postgres..."
until pg_isready -h postgres -p 5432 -U logto; do
  sleep 2
done

echo "Postgres ready."

# Ensure default tenant exists
echo "Ensuring default tenant exists..."
npx logto tenant get default || npx logto tenant create default

# Ensure OIDC tenant 'myapp' exists
echo "Ensuring OIDC tenant 'myapp' exists..."
npx logto tenant get myapp || npx logto tenant create myapp

echo "Tenants ready. Starting Logto..."
exec npm start
