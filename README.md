# Raspberry Pi Project

## 🧩 Initial setup

Flash your SD card with the Pi image
Turn on the Pi on and wait about 2 minites for the initial setup (until the green led stops blinking)
Turn off the Pi
Turn on the Pi on and wait the green led stops blinking
Connect to the Pi via ssh using wifi (use LanScan app if necessary)

Update the SO:
```bash 
sudo apt update
sudo apt upgrade
```

Install vim
```bash
sudo apt install vim
```

Set your locale variables: Add these lines to your ~/.bashrc or ~/.profile:
```bash
vim .bashrc
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

```

Configure your local:
```bash
sudo dpkg-reconfigure locales
```

Set your Git credentials:

```bash
git config --global user.name "Ricardo Rocha"
git config --global user.email "rrochati@gmail.com"
git config --global credential.helper store
add your priv key to .ssh/your_key
chmod 600 .ssh/rrocha.priv
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/rrocha.priv
```

## 🧩 Set config change tracking:
Step 1: Create the Repository Structure

```bash
# Create the main directory
mkdir -p /home/rrocha/pi-config
cd /home/pi/pi-config

# Initialize git repository
git init

# Create directory structure
mkdir -p {scripts,system-snapshots,configs,documentation}
````

Create the scripts/capture-system-state.sh, scripts/quick-update.sh and track-install.sh

Make Scripts Executable
```bash
chmod +x scripts/capture-system-state.sh
chmod +x scripts/quick-update.sh
chmod +x scripts/track-install.sh
```

Create .gitignore with the content:
```bash
# Temporary files
*.tmp
*.swp
*.swo

# Log files (except our tracking logs)
*.log
!documentation/*.log

# OS generated files
.DS_Store
Thumbs.db
```


Initial Commit and GitHub Setup
```bash
# Create initial commit
git add .
git commit -m "Initial Raspberry Pi configuration tracker setup"

# Add remote repository (replace with your GitHub repo URL)
git remote add origin https://github.com/yourusername/raspberry-pi-config.git

# Push to GitHub
git branch -M main
git push -u origin main
```

**Initial Documentation**:
# Raspberry Pi System Configuration Tracker

This repository tracks the configuration and package installations of my Raspberry Pi.

## Scripts

- `scripts/capture-system-state.sh` - Captures complete system state
- `scripts/quick-update.sh` - Quick update with description
- `scripts/track-install.sh` - Track package installations

## Usage Examples

```bash
# After installing a package
sudo apt install neofetch
./scripts/track-install.sh "neofetch" "apt"

# After configuration changes
sudo dpkg-reconfigure locales
./scripts/quick-update.sh "Updated locale configuration to en_US.UTF-8"

# Manual system snapshot
./scripts/capture-system-state.sh
```

## Directory Structure

- `system-snapshots/` - Timestamped system state captures
- `scripts/` - Automation scripts
- `documentation/` - Installation logs and notes
- `configs/` - Important configuration file backups