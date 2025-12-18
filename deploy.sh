#!/bin/bash
set -e # Exit immediately if a command fails

# Add flutter to PATH if it's not already there
export PATH="$PATH:/Users/user/development/flutter/bin"

# Ensure we are in the project root
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Error: Please run this script from the project root directory."
    exit 1
fi

echo "🌐 LaUnion Web Build & Deployment (Live on Main)"

# Build the web app with correct base href for subdirectory hosting
echo "🏗️  Building web app..."
flutter build web --release --base-href="/LaUnion/"

# 1. Save source code to 'development' branch
echo "📝 Saving source code to development branch..."
git add .
# Ensure build directory is NOT added to development branch
git reset -- build/ 2>/dev/null || true

# Commit and push to development
if ! git diff-index --quiet HEAD --; then
    git commit -m "Source update: $(date '+%Y-%m-%d %H:%M:%S')"
fi
echo "🚀 Pushing source to development branch..."
git push origin main:development --force

# 2. Deploy ONLY build artifacts to main branch
echo "📦 Preparing main branch deployment..."

# Create a temporary directory for build artifacts
TEMP_BUILD_DIR=$(mktemp -d)
cp -r build/web/* "$TEMP_BUILD_DIR/"

# Switch to (or create) a temporary branch for the live build
git branch -D live-build-temp 2>/dev/null || true
git checkout --orphan live-build-temp

# Clear EVERYTHING in the current branch
echo "🧹 Cleaning temporary branch..."
git rm -rf . --quiet > /dev/null

# Copy build artifacts to the root
echo "🚚 Moving build artifacts to root..."
cp -r "$TEMP_BUILD_DIR"/* .
rm -rf "$TEMP_BUILD_DIR"

# Add and commit the build
git add .
git commit -m "Web deployment (Live): $(date '+%Y-%m-%d %H:%M:%S')" --quiet

echo "🚀 Pushing web build to main branch (Live site)..."
git push origin live-build-temp:main --force

# Cleanup: Switch back to development locally (since main is now for builds)
echo "🧹 Cleaning up..."
git checkout development
git branch -D live-build-temp

echo "✅ Web build successfully deployed to main!"
echo "💡 IMPORTANT: Your source code is now on the 'development' branch."
echo "💡 From now on, work on 'development' and run this script to deploy."
