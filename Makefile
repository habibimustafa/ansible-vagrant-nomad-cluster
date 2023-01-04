vagrant-init:
	ansible-playbook -vv create-vagrant.yml --ask-become-pass

consul-init:
	ansible-playbook -vv create-consul-cluster.yml --ask-become-pass

nomad-init:
	ansible-playbook -vv create-nomad-cluster.yml --ask-become-pass
