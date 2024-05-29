#!/bin/bash

#Prometheus installation

#1. Use wget to download Prometheus to the monitoring server.
sudo wget https://github.com/prometheus/prometheus/releases/download/v2.37.6/prometheus-2.37.6.linux-amd64.tar.gz

#2. Extract the archived Prometheus files.
sudo tar xvfz prometheus-*.tar.gz

#3. Delete the archive or move it to a different location for storage.
sudo rm prometheus-*.tar.gz

#4. Create two new directories for Prometheus to use.
sudo mkdir /etc/prometheus /var/lib/prometheus

#5. Move into the main directory of the extracted prometheus folder.
cd prometheus-2.37.6.linux-amd64

#6. Move the prometheus and promtool directories to the /usr/local/bin/ directory. 
sudo mv prometheus promtool /usr/local/bin/

#7. Move the prometheus.yml YAML configuration file to the /etc/prometheus directory.
sudo mv prometheus.yml /etc/prometheus/prometheus.yml

#8. These files should also be moved to the etc/prometheus directory.
sudo mv consoles/ console_libraries/ /etc/prometheus/

#9. Verify that Prometheus is successfully installed.
prometheus --version

#Configuration Prometheus as a Service

#1. Create a prometheus user. 
sudo useradd -rs /bin/false prometheus

#2. Assign ownership of the two directories created in the previous section to the new prometheus user.
sudo chown -R prometheus: /etc/prometheus /var/lib/prometheus

#3. Download a prometheus.service file from my GitHub Repository.

wget https://github.com/goldexpi/Prometheus-Grafana/blob/main/prometheus.service

#4. Reload the systemctl daemon.
sudo systemctl daemon-reload

#5. Configure the prometheus service to automatically start when the system boots.
sudo systemctl enable prometheus

#6. Start the prometheus service and review the status command to ensure it is active.

sudo systemctl start prometheus
sudo systemctl status prometheus

#Installation and Configuration Node_Exporter on the Client

#1. Use wget to download this release.
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz

#2. Extract the application.
tar xvfz node_exporter-*.tar.gz

#3. Move the executable to usr/local/bin so it is accessible throughout the system.
sudo mv node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin

#4. Remove any remaining files.
rm -r node_exporter-1.5.0.linux-amd64*

#5. Create a node_exporter user.
sudo useradd -rs /bin/false node_exporter

#6. Download a node_exporter.service file for systemctl to use from my GitHub Repository 
wget https://github.com/goldexpi/Prometheus-Grafana/blob/main/node_exporter.service

#7. Use the systemctl enable command to automatically launch Node Exporter at boot time.
sudo systemctl enable node_exporter

#8. Reload the systemctl daemon, start Node Exporter, and verify its status. The service should be active. 

sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl status node_exporter

#Installation and Deploying Grafana-Server

#1. Install some required utilities using apt.
sudo apt-get install -y apt-transport-https software-properties-common

#2. Import the Grafana GPG key.
sudo wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key

#3. Add the Grafana “stable releases” repository.
echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

#4. Update the packages in the repository, including the new Grafana package.
sudo apt-get update

#5. Install the open-source version of Grafana.
sudo apt-get install grafana

#6. Reload the systemctl daemon.
sudo systemctl daemon-reload

#7. Enable and start the Grafana server.

sudo systemctl enable grafana-server.service
sudo systemctl start grafana-server

#8. Verify the status of the Grafana server and ensure it is in the active state.
sudo systemctl status grafana-server
