#!/bin/bash

# Generate a random 4-symbol tag that matches the regex
TAG=$(openssl rand -base64 8 | tr '[:upper:]' '[:lower:]' | tr -dc 'a-z0-9' | head -c 4)

# Set the instance name and zone
MY_INSTANCE_NAME="sarai-${TAG}"
ZONE=us-central1-a

echo "Creating instance ${MY_INSTANCE_NAME} in zone ${ZONE}"

# Create the VM instance with the specified configurations and random tag
gcloud compute instances create $MY_INSTANCE_NAME \
    --image-family=ubuntu-2204-lts \
    --image-project=ubuntu-os-cloud \
    --machine-type=n1-standard-16 \
    --scopes userinfo-email,cloud-platform \
    --metadata-from-file startup-script=startup-script.sh \
    --zone $ZONE \
    --tags http-server \
    --accelerator type=nvidia-tesla-t4,count=1 \
    --maintenance-policy TERMINATE --restart-on-failure \
    --boot-disk-size=200GB \

# Create a firewall rule to allow HTTP traffic on port 5000
gcloud compute firewall-rules create default-allow-http-5000 \
    --allow tcp:5000 \
    --source-ranges 0.0.0.0/0 \
    --target-tags http-server \
    --description "Allow port 5000 access to http-server"

# Check the progress of the instance creation:
# gcloud compute instances get-serial-port-output $MY_INSTANCE_NAME --zone $ZONE
