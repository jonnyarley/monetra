#!/bin/bash
# Pre-build script for Vercel deployment
# Switches to PostgreSQL schema for production

set -e

echo "🚀 Running pre-build script..."

# Check if we're in production (Vercel sets VERCEL=1)
if [ "$VERCEL" = "1" ] || [ "$NODE_ENV" = "production" ]; then
  echo "📦 Production build detected - using PostgreSQL schema"

  # Copy PostgreSQL schema
  cp prisma/schema.postgresql.prisma prisma/schema.prisma

  echo "✅ PostgreSQL schema activated"
else
  echo "💻 Development build detected - using SQLite schema"

  # Copy SQLite schema (default for local development)
  cp prisma/schema.sqlite.prisma prisma/schema.prisma

  echo "✅ SQLite schema activated"
fi

# Generate Prisma Client
echo "🔧 Generating Prisma Client..."
npx prisma generate

echo "✅ Pre-build complete!"
