#!/bin/bash
# Simply run this file to install the Grafana in your system and check the status. Run with command `bash grafana-install.sh`
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget
sudo wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key
echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | 
sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update #Update the system
sudo apt-get install grafana -y
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
sudo systemctl status grafana-server
