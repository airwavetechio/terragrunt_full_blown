#!/bin/bash

if [ -f /etc/lsb-release ]; then
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    sudo apt-get install -y apt-transport-https openjdk-11-jdk
    echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
    sudo apt-get update && sudo apt-get -y install elasticsearch=6.3.2
fi
if [ -f /etc/redhat-release ]; then
    sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
    sudo bash -c 'cat <<EOF > /etc/yum.repos.d/elasticsearch.repo
[elasticsearch]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md
EOF'
    sudo yum install -y java
    sudo yum install -y --enablerepo=elasticsearch elasticsearch
fi

sudo bash -c 'cat <<EOF > /etc/elasticsearch/elasticsearch.yml
cluster.name: airwave-es
network.host: "0.0.0.0"
discovery.type: single-node
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
EOF'
sudo chown :elasticsearch /etc/elasticsearch/elasticsearch.yml
sudo systemctl enable elasticsearch
sudo systemctl restart elasticsearch