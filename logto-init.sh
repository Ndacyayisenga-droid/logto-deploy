#!/bin/sh
set -e

# Run seeding only once
if [ ! -f /root/.logto/.seeded ]; then
  echo "👉 Running initial DB seed..."
  npm run cli db seed -- --swe || true
  npm run alteration deploy || true
  npm run cli tenant create -- --default || true
  touch /root/.logto/.seeded
else
  echo "✅ Database already seeded, skipping..."
fi
