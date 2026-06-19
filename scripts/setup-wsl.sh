#!/usr/bin/env bash
# Setup de l'environnement FortiSIEM IaC sous WSL (Ubuntu).
# Idempotent : peut être relancé sans casser une install existante.
set -euo pipefail

echo "== Docker =="
if ! command -v docker &> /dev/null; then
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo usermod -aG docker "$USER"
else
  echo "Docker déjà installé : $(docker --version)"
fi

echo "== Terraform =="
if ! command -v terraform &> /dev/null; then
  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update
  sudo apt install -y terraform
else
  echo "Terraform déjà installé : $(terraform -version | head -1)"
fi

echo "== Ansible =="
if ! command -v ansible &> /dev/null; then
  sudo apt install -y ansible-core
else
  echo "Ansible déjà installé : $(ansible --version | head -1)"
fi

echo "== Collection community.docker =="
ansible-galaxy collection install community.docker

echo "== Fix iptables (conflit nft/legacy connu sous WSL2 + systemd) =="
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

echo "== Démarrage du service Docker =="
sudo systemctl enable docker
sudo systemctl restart docker
sudo systemctl status docker --no-pager

echo "Setup terminé. Relance un terminal (ou 'newgrp docker') pour que l'appartenance au groupe docker soit prise en compte."
