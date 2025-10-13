# python 3.11

## Use Conda/Miniconda (Recommended)

```bash
# Download Miniconda for ARM64

sudo apt install wget
cd /tmp
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh

# Install Miniconda
bash Miniconda3-latest-Linux-aarch64.sh -b -p $HOME/miniconda3

# Initialize conda
$HOME/miniconda3/bin/conda init bash
source ~/.bashrc

# Install Python 3.11
conda create -n python311 python=3.11
                                                            
# To activate this environment, use 
#
#     $ conda activate python311
#
# To deactivate an active environment, use
#
#     $ conda deactivate

conda activate python311

# Verify
python --version

# Track this installation
cd ~/raspberry-pi-config
./scripts/quick-update.sh "Installed Miniconda and created Python 3.11 environment"

# Push your changes:
git push --set-upstream origin feat/python3.11
```
