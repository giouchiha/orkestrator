#
# Makefile for Kool Orkestrator
#
# author: jorge.medina@koolops.com.mx
# desc: Script to build the vagrant development enviroment.

NAME = orkestrator
VERSION = 1.0.0

.PHONY: all vagrant bootstrap build test deploy clean destroy help

all: help

vagrant:
	@echo ""
	@echo "Building local development environment based on vagrant."
	@echo ""
	vagrant up
	vagrant status

bootstrap:
	@echo ""
	@echo "Bootstraping local development enviroment based on vagrant ."
	@echo ""
	rm -rf /etc/ansible;
	ln -fs /vagrant /etc/ansible
	cd /etc/ansible
	bin/bootstrap.sh

build:
	@echo ""
	@echo "Building local development enviroment."
	@echo ""
	cd /etc/ansible
	bin/build.sh local development

test:
	@echo ""
	@echo "Testing local development environment."
	@echo ""
	cd /etc/ansible
	ansible-playbook central-site.yml --syntax-check

deploy:
	@echo ""
	@echo "Deploying central devops service."
	@echo ""
	cd /etc/ansible
	bin/deploy-central-devops-server.sh
	bin/postsetup.sh

clean:
	@echo ""
	@echo "Cleaning local development enviroment."
	@echo ""
	cd /etc/ansible
	git checkout -- ansible.cfg inventory/local/development

destroy:
	@echo ""
	@echo "Destroying local development enviroment."
	@echo ""
	vagrant destroy -f
	vagrant global-status --prune

help:
	@echo ""
	@echo "Please use \`make <target>' where <target> is one of"
	@echo ""
	@echo "  vagrant   Provision the local development enviroment."
	@echo "  bootstrap Bootstrap the local development enviroment."
	@echo "  build     Builds the local development enviroment."
	@echo "  test      Tests for the local development enviroment."
	@echo "  deploy    Deploy the local development enviroment."
	@echo "  clean     Cleans local changes on ansible settings."
	@echo "  destroy   Destroys the local development enviroment."
	@echo ""
	@echo ""
