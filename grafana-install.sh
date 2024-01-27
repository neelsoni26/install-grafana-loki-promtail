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
sudo apt-get install -y docker.io
# sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
mkdir grafana-configs
cd grafana-configs
wget https://raw.githubusercontent.com/grafana/loki/v2.8.0/cmd/loki/loki-local-config.yaml -O loki-config.yaml
wget https://raw.githubusercontent.com/grafana/loki/v2.8.0/clients/cmd/promtail/promtail-docker-config.yaml -O promtail-config.yaml
sudo docker run -d --name loki -v $(pwd):/mnt/config -p 3100:3100 grafana/loki:2.8.0 --config.file=/mnt/config/loki-config.yaml
sudo docker run -d --name promtail -v $(pwd):/mnt/config -v /var/log:/var/log --link loki grafana/promtail:2.8.0 --config.file=/mnt/config/promtail-config.yaml
sudo docker ps
echo "Grafana with Loki and Promtail is installed and configured."
echo "OPEN PORT 3000 and 3100 FROM SECURITY GROUP"
