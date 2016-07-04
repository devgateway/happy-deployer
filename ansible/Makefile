
## Avoid conflicts with files of the same name
## @see: http://www.gnu.org/savannah-checkouts/gnu/make/manual/html_node/Phony-Targets.html
.PHONY: dummy bootstrap bootstrap-local provision provision-local


## The default target, if no target argument is provided to `make`.
## Update an environment with the latest changes from code.
dummy:
	@echo 'Here is a list of available commands:'
	@grep -iE "^[a-z_-]+:" $(lastword $(MAKEFILE_LIST)) | cut -d: -f1 | grep -v dummy | xargs -i{} echo "  $$ make {}"


## Bootstrap Ansible.
bootstrap:bootstrap-local
bootstrap-local:
	@echo 'Bootstrapping Ansible:'
	@echo 'Installing the EPEL repository.'
	@rpm --quiet --force -Uh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	@gpg --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
	@echo 'Install Ansible from EPEL.'
	@yum -y install ansible
	@echo 'Update Ansible configuration.'
	@sudo /usr/bin/mkdir -p /etc/ansible/
	@sudo /usr/bin/cp hosts /etc/ansible/


## Provision the localhost using Ansible Playbooks.
provision:provision-local
provision-local:
	@echo 'Provisioning the localhost using Ansible Playbooks:'
	@test -e '../Vagrantsettings.local.yml' && (echo "Using ../Vagrantsettings.local.yml" && ansible-playbook --extra-vars "@../Vagrantsettings.local.yml" -b main.yml) || true
	@test ! -e '../Vagrantsettings.local.yml' && (echo "Using ../Vagrantsettings.yml" && ansible-playbook --extra-vars "@../Vagrantsettings.yml" -b main.yml) || true
