vagrant-init:
	ansible-playbook -vv create-vagrant.yml --ask-become-pass

consul-cluster:
	ansible-playbook -vv create-consul-cluster.yml --ask-become-pass

nomad-cluster:
	ansible-playbook -vv create-nomad-cluster.yml --ask-become-pass

start:
	vagrant-init
	consul-cluster
	nomad-cluster

destroy:
	vagrant destroy
