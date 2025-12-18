#!/bin/bash
set -e # Exit immediately if a command fails

# Error recovery: ensure we always return to main
trap "git checkout main; git branch -D main-temp 2>/dev/null; git branch -D gh-pages-temp 2>/dev/null" ERR

# Add flutter to PATH if it's not already there
export PATH="$PATH:/Users/user/development/flutter/bin"


# Ensure we are in the project root
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Error: Please run this script from the project root directory."
    exit 1
fi

# Increase buffer size and switch to HTTP/1.1 for large pushes to prevent RPC/SSL failed errors
echo "⚙️ Configuring git buffer and protocol..."
git config http.postBuffer 524288000
git config http.version HTTP/1.1

# Save the project root directory and the authenticated remote URL
ROOT_DIR=$(pwd)
REMOTE_URL=$(git remote get-url origin)

echo "🌐 LaUnion Web Build & Main Update"

# Build the web app with correct base href for subdirectory hosting
echo "🏗️  Building web app..."
flutter build web --release --base-href="/LaUnion/"

# 1. Update main branch with source and build artifacts
echo "📝 Committing changes and build artifacts to main..."
git add .
git add -f build/web

# Check if there are changes to commit (or if we are ahead of origin)
if ! git diff-index --quiet HEAD -- || [ -n "$(git log origin/main..main 2>/dev/null)" ]; then
    if ! git diff-index --quiet HEAD --; then
        git commit -m "Update source and web build: $(date '+%Y-%m-%d %H:%M:%S')"
    fi
    echo "🚀 Pushing updated code to main on GitHub..."
    git push origin main
else
    echo "ℹ️ Main branch is already up to date on GitHub."
fi

# 2. Deploy ONLY build artifacts to gh-pages using an orphan branch strategy from root
echo "📦 Preparing gh-pages deployment from root..."

# Save the current state
git branch -D gh-pages-temp 2>/dev/null || true
git checkout --orphan gh-pages-temp

# Clear the index and working directory (locally only in this branch)
echo "🧹 Cleaning temporary branch..."
git rm -rf . --quiet > /dev/null

# Pull the web build contents into the root of this branch
echo "🚚 Moving build artifacts to root..."
git checkout main -- build/web/
mv build/web/* .
rm -rf build/

# Add and commit
git add .
git commit -m "Web deployment: $(date '+%Y-%m-%d %H:%M:%S')" --quiet

echo "🚀 Pushing web build to gh-pages..."
# This uses the root repo's remote which we know works (used for main)
git push origin gh-pages-temp:gh-pages --force

# Cleanup: Switch back to main and delete the temp branch
echo "🧹 Cleaning up temporary branch..."
git checkout main
git branch -D gh-pages-temp

echo "✅ Web build successfully deployed to main and gh-pages!"


