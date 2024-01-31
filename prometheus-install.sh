#!/bin/bash
# Simply run this file to install the Prometheus and cAdvisor in your system. Run with command `bash prometheus-install.sh`
sudo apt-get update
sudo apt-get install -y docker.io docker-compose
mkdir prometheus && cd prometheus
wget https://raw.githubusercontent.com/prometheus/prometheus/main/documentation/examples/prometheus.yml
echo -e "  - job_name: cadvisor\n    static_configs:\n      - targets:\n          - cadvisor:8080" >> prometheus.yml
wget https://raw.githubusercontent.com/neelsoni26/install-grafana-loki-promtail/master/docker-compose.yml
docker-compose up -d
echo "Prometheus, cAdvisor, Reddis are installed and configured."
echo "OPEN PORT 9090, 8080 and 6379 FROM SECURITY GROUP"
