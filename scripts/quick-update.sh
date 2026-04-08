#!/bin/bash

DESCRIPTION="$1"

if [ -z "$DESCRIPTION" ]; then
    echo "Usage: ./quick-update.sh 'Description of changes'"
    exit 1
fi

echo "🔄 Quick system update: $DESCRIPTION"

# Run the capture script
cd /home/pi/pi-config
./scripts/capture-system-state.sh

# Git operations
git add .
git commit -m "System update: $DESCRIPTION"

echo "✅ Changes committed to git repository"
