#!/bin/sh
set -e

echo "🔍 Checking database state..."

# Run initial seed only if not already done
if [ ! -f /root/.logto/.seeded ]; then
  echo "👉 Running initial DB seed..."
  npm run cli db seed -- --swe || true
  npm run alteration deploy || true
  touch /root/.logto/.seeded
else
  echo "✅ Database already seeded, skipping..."
fi

# Always make sure default tenant exists
echo "🔍 Ensuring default tenant exists..."
npm run cli tenant create -- --default || echo "ℹ️ Default tenant already exists"

echo "✅ Startup checks done, launching Logto..."
