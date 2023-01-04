vagrant:
	ansible-playbook -vv create-vagrant.yml --ask-become-pass

consul:
	ansible-playbook -vv create-consul-cluster.yml --ask-become-pass

nomad:
	ansible-playbook -vv create-nomad-cluster.yml --ask-become-pass

destroy:
	vagrant destroy