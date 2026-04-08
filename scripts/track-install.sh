#!/bin/bash

PACKAGE_NAME="$1"
INSTALL_TYPE="$2"  # apt, pip, or manual

if [ -z "$PACKAGE_NAME" ]; then
    echo "Usage: ./track-install.sh 'package-name' [apt|pip|manual]"
    exit 1
fi

echo "📦 Tracking installation of: $PACKAGE_NAME"

# Create log entry
echo "$(date): Installed $PACKAGE_NAME ($INSTALL_TYPE)" >> documentation/install-log.txt

# Capture system state
./scripts/capture-system-state.sh

# Git commit
git add .
git commit -m "Installed $PACKAGE_NAME via $INSTALL_TYPE"

echo "✅ Installation of $PACKAGE_NAME tracked and committed"
