#!/bin/bash

serverip=your_ip_Adresse

# Vérification de l'installation du Zabbix Agent
if dpkg -s zabbix-agent >/dev/null 2>&1; then
  echo "Le Zabbix Agent est déjà installé sur le système."
else
  echo "Le Zabbix Agent n'est pas installé. Installation en cours..."
  apt update
  apt install -y zabbix-agent
fi

# Configuration du fichier zabbix_agentd.conf
echo "Configuration du fichier zabbix_agentd.conf..."

# Remplacez 'Adresse_du_serveur_Zabbix' par l'adresse IP ou le nom de domaine de votre serveur Zabbix
sed -i 's/Server=${serverip}/Server=${serverip}/g' /etc/zabbix/zabbix_agentd.conf

# Vérification de l'état du service Zabbix Agent
if systemctl is-enabled zabbix-agent >/dev/null 2>&1; then
  echo "Le Zabbix Agent est déjà activé."
else
  echo "Activation du Zabbix Agent..."
  systemctl enable zabbix-agent
  systemctl start zabbix-agent
fi
echo "Vérification et configuration du Zabbix Agent terminées."
exit 0

echo "Installation et configuration du Zabbix Agent terminées avec succès."
