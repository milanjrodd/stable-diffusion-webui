#!/bin/bash

# Install or update needed software
echo "======="
echo "Installing or updating needed software..."
echo "======="
apt-get update
apt-get install -yq supervisor wget git python3 python3-venv software-properties-common

# Install Python 3.10
echo "======="
echo "Installing Python 3.10..."
echo "======="
add-apt-repository ppa:deadsnakes/ppa -y
apt-get update
apt-get install -yq python3.10 python3.10-venv python3.10-distutils

# Set Python 3.10 as the default
echo "======="
echo "Setting Python 3.10 as the default..."
echo "======="
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

# Upgrade pip
echo "======="
echo "Upgrading pip..."
echo "======="
pip3 install --upgrade pip

# Install Cloud Ops Agent
echo "======="
echo "Installing Cloud Ops Agent..."
echo "======="
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

# Stop Cloud Ops Agent
echo "======="
echo "Stopping Cloud Ops Agent..."
echo "======="
sudo systemctl stop google-cloud-ops-agent

# Install CUDA
echo "======="
echo "Installing CUDA..."
echo "======="
curl https://raw.githubusercontent.com/GoogleCloudPlatform/compute-gpu-installation/main/linux/install_gpu_driver.py --output install_gpu_driver.py
sudo python3 install_gpu_driver.py

# Account to own server process
echo "======="
echo "Creating account to own server process..."
echo "======="
useradd -m -d /home/sarai sarai

# Install sarai
echo "======="
echo "Installing sarai with pipe bash..."
echo "======="
su - sarai -c "curl -s https://raw.githubusercontent.com/milanjrodd/stable-diffusion-webui/master/install.sh | bash"


# Set ownership to newly created account
echo "======="
echo "Setting ownership to newly created account..."
echo "======="
chown -R sarai:sarai /home/sarai

# Create a Supervisor configuration file for sarai
echo "======="
echo "Creating a Supervisor configuration file for sarai..."
echo "======="
cat > /etc/supervisor/conf.d/sarai.conf << EOL
[program:sarai]
command=/home/sarai/stable-diffusion-webui/webui.sh --api --theme light --port 5000 --listen
directory=/home/sarai/stable-diffusion-webui
user=sarai
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
stderr_logfile=/var/log/sarai.err.log
stdout_logfile=/var/log/sarai.out.log
EOL

# Start service via supervisorctl
echo "======="
echo "Starting service via supervisorctl..."
echo "======="
supervisorctl reread
supervisorctl update
