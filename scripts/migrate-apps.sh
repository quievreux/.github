#!/bin/bash

# ==============================================================================
# Migration Script: @quievreux/ui -> @squievreux/ui
# Usage: ./migrate-apps.sh "repo-name-1 repo-name-2 ..."
# Requirements: GitHub CLI (gh) installed and authenticated
# ==============================================================================

REPOS=$1

if [ -z "$REPOS" ]; then
  echo "Usage: $0 \"repo1 repo2 ...\""
  exit 1
fi

for REPO in $REPOS; do
  echo "----------------------------------------------------"
  echo "🚀 Migrating $REPO..."
  
  # 1. Clone
  echo "Cloning $REPO..."
  if [[ "$REPO" != */* ]]; then
    FULL_REPO="skquievreux/$REPO"
  else
    FULL_REPO="$REPO"
  fi
  
  gh repo clone "$FULL_REPO" "temp_$REPO" || { echo "❌ Failed to clone $FULL_REPO"; continue; }
  cd "temp_$REPO" || { echo "❌ Failed to enter temp_$REPO"; continue; }

  # 2. Branch
  git checkout -b chore/migrate-ui-scope

  # 3. Perform Migration
  echo "📦 Updating dependencies..."
  # Use pnpm if pnpm-lock.yaml exists, otherwise npm
  if [ -f "pnpm-lock.yaml" ]; then
    pnpm remove @quievreux/ui --silent
    pnpm add @squievreux/ui
  else
    npm uninstall @quievreux/ui
    npm install @squievreux/ui
  fi

  # 4. Remove .npmrc
  if [ -f ".npmrc" ]; then
    echo "🗑️ Removing .npmrc..."
    rm .npmrc
  fi

  # 5. Bulk Replace in Code (Optional but recommended)
  echo "🔍 Replacing imports in source code..."
  grep -rl "@quievreux/ui" . --exclude-dir=node_modules --exclude-dir=.git | xargs sed -i 's/@quievreux\/ui/@squievreux\/ui/g'

  # 6. Commit & Push
  git add .
  git commit -m "chore: migrate to @squievreux/ui and remove GPR authentication"
  git push origin chore/migrate-ui-scope

  # 7. Create Pull Request
  gh pr create \
    --title "chore: migrate to @squievreux/ui" \
    --body "This PR migrates the Design System from the private @quievreux scope to the public @squievreux scope. It also removes the unnecessary .npmrc file." \
    --base main

  # 8. Cleanup
  cd ..
  rm -rf "temp_$REPO"
  
  echo "✅ Finished $REPO"
done

echo "🎉 Migration campaign completed!"
