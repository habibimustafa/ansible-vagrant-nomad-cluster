vagrant-init:
	export ANSIBLE_HOST_KEY_CHECKING=False && \
	ansible-playbook -vv create-vagrant.yml --ask-become-pass

consul-cluster:
	export ANSIBLE_HOST_KEY_CHECKING=False && \
	ansible-playbook -vv create-consul-cluster.yml --ask-become-pass

nomad-cluster:
	export ANSIBLE_HOST_KEY_CHECKING=False && \
	ansible-playbook -vv create-nomad-cluster.yml --ask-become-pass

worker-cluster:
	export ANSIBLE_HOST_KEY_CHECKING=False && \
	ansible-playbook -vv create-worker-cluster.yml --ask-become-pass

vault-cluster:
	export ANSIBLE_HOST_KEY_CHECKING=False && \
	ansible-playbook -vv create-vault-cluster.yml --ask-become-pass

consul-upgrade:
	export ANSIBLE_HOST_KEY_CHECKING=False && \
	ansible-playbook -vv upgrade-consul.yml --ask-become-pass

test:
	export ANSIBLE_HOST_KEY_CHECKING=False && \
	ansible-playbook -vv test.yml --ask-become-pass

start: vagrant-init consul-cluster nomad-cluster

destroy:
	vagrant destroy
