#!/bin/bash

# Install or update needed software
apt-get update
apt-get install -yq supervisor wget git python3 python3-venv software-properties-common

# Install Python 3.10
add-apt-repository ppa:deadsnakes/ppa -y
apt-get update
apt-get install -yq python3.10 python3.10-venv python3.10-distutils

# Set Python 3.10 as the default
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

# Upgrade pip
pip3 install --upgrade pip

# Install Cloud Ops Agent
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

# Stop Cloud Ops Agent
sudo systemctl stop google-cloud-ops-agent

# Install CUDA
curl https://raw.githubusercontent.com/GoogleCloudPlatform/compute-gpu-installation/main/linux/install_gpu_driver.py --output install_gpu_driver.py
sudo python3 install_gpu_driver.py

# Account to own server process
useradd -m -d /home/sarai sarai

# Install sarai
sudo bash <(wget -qO- https://raw.githubusercontent.com/milanjrodd/stable-diffusion-webui/master/webui.sh)

# Set ownership to newly created account
chown -R sarai:sarai /opt/sarai

# Create a Supervisor configuration file for sarai
cat > /etc/supervisor/conf.d/sarai.conf << EOL
[program:sarai]
command=/opt/sarai/stable-diffusion-webui/webui.sh --api --theme light --port 5000 --listen
directory=/opt/sarai/stable-diffusion-webui
user=sarai
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
stderr_logfile=/var/log/sarai.err.log
stdout_logfile=/var/log/sarai.out.log
EOL

# Start service via supervisorctl
supervisorctl reread
supervisorctl update
