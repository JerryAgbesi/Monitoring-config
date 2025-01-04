#!/bin/bash

# A script to install Node Exporter to run in the background as a service

# Install Node Exporter
sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz

sudo tar xzf node_exporter-1.8.2.linux-amd64.tar.gz

#Remove node_exporter-1.8.0.linux-amd64.tar.gz
sudo rm -rf node_exporter-1.8.2.linux-amd64.tar.gz

# Move Node Exporter to /etc/node_exporter
sudo mv node_exporter-1.8.2.linux-amd64 /etc/node_exporter

sudo touch /etc/systemd/system/node_exporter.service

sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
ExecStart=/etc/node_exporter/node_exporter
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl restart node_exporter

# Check status
sudo systemctl status node_exporter

