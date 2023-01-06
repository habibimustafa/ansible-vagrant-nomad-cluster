vagrant-init:
	export ANSIBLE_HOST_KEY_CHECKING=False && \
	ansible-playbook -vv create-vagrant.yml --ask-become-pass

consul-cluster:
	export ANSIBLE_HOST_KEY_CHECKING=False && \
	ansible-playbook -vv create-consul-cluster.yml --ask-become-pass

nomad-cluster:
	export ANSIBLE_HOST_KEY_CHECKING=False && \
	ansible-playbook -vv create-nomad-cluster.yml --ask-become-pass

start: vagrant-init consul-cluster nomad-cluster

destroy:
	vagrant destroy
