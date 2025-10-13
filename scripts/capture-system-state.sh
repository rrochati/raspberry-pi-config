#!/bin/bash

echo "📸 Capturing Raspberry Pi system state..."

# Create timestamped directory
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
SNAPSHOT_DIR="system-snapshots/$TIMESTAMP"
mkdir -p "$SNAPSHOT_DIR"

echo "📁 Snapshot directory: $SNAPSHOT_DIR"

# Capture installed packages
echo "📦 Capturing package information..."
dpkg --get-selections > "$SNAPSHOT_DIR/installed-packages.txt"
apt list --installed > "$SNAPSHOT_DIR/apt-packages-detailed.txt"

# Capture Python environment
echo "🐍 Capturing Python environment..."
python3 --version > "$SNAPSHOT_DIR/python-version.txt"
pip3 list > "$SNAPSHOT_DIR/pip-packages.txt"
pip3 freeze > "$SNAPSHOT_DIR/requirements.txt"

# Capture system information
echo "💻 Capturing system information..."
uname -a > "$SNAPSHOT_DIR/system-info.txt"
cat /etc/os-release > "$SNAPSHOT_DIR/os-release.txt"
locale > "$SNAPSHOT_DIR/locale-settings.txt"
cat /etc/locale.gen | grep -v "^#" | grep -v "^$" > "$SNAPSHOT_DIR/enabled-locales.txt"

# Capture important config files
echo "⚙️  Capturing configuration files..."
cp /etc/hostname "$SNAPSHOT_DIR/" 2>/dev/null
cp /etc/hosts "$SNAPSHOT_DIR/" 2>/dev/null
cp /boot/config.txt "$SNAPSHOT_DIR/" 2>/dev/null
cp ~/.bashrc "$SNAPSHOT_DIR/bashrc" 2>/dev/null
cp /etc/default/locale "$SNAPSHOT_DIR/" 2>/dev/null

# Capture hardware information
echo "🔧 Capturing hardware information..."
cat /proc/cpuinfo | head -20 > "$SNAPSHOT_DIR/cpu-info.txt"
free -h > "$SNAPSHOT_DIR/memory-info.txt"
df -h > "$SNAPSHOT_DIR/disk-usage.txt"

# Create summary file
echo "📋 Creating summary..."
cat > "$SNAPSHOT_DIR/snapshot-summary.md" << EOF
# System Snapshot - $TIMESTAMP

## System Information
- OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f 2)
- Kernel: $(uname -r)
- Python: $(python3 --version)
- Locale: $(locale | grep LANG= | cut -d '=' -f 2)

## Package Counts
- APT Packages: $(dpkg --get-selections | wc -l)
- Python Packages: $(pip3 list | tail -n +3 | wc -l)

## Captured Files
$(ls -la "$SNAPSHOT_DIR" | tail -n +2 | awk '{print "- " $9}')
EOF

echo "✅ System state captured successfully in $SNAPSHOT_DIR"
