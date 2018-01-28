#!/usr/bin/env bash
apt-get update

# install tools for managing ppa repositories
apt-get -y install software-properties-common unzip vim

# add extra repositories
apt-add-repository -y ppa:ansible/ansible
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# update cache with new repositories data
apt-get update

# upgrade the system
apt-get -y upgrade

# add ansible dependencies
apt-get -y install build-essential libssl-dev libffi-dev python-dev python-pip
update-locale LANG=en_US.UTF-8
pip install --upgrade pip
pip install --upgrade shade

# update ansible
apt-get -y install ansible
apt-get -y install python-shade

# add google cloud sdk
apt-get install -y --allow-unauthenticated google-cloud-sdk 

# add terraform
wget https://releases.hashicorp.com/terraform/0.11.0/terraform_0.11.0_linux_amd64.zip
unzip terraform_0.11.0_linux_amd64.zip -d /usr/local/bin
rm terraform_0.11.0_linux_amd64.zip

# add graph builder tool for terraform
apt-get install -y graphviz

# clean up cached packages
apt-get clean all

# Copy special files into /home/vagrant (from inside the mgmt node)
chown -R vagrant:vagrant /home/vagrant
# Preserve original Ansible configuration files
cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.org
cp /etc/ansible/hosts /etc/ansible/hosts.org

