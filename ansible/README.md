

### Install ansible on a Enterprise Linux 7 host
```
make bootstrap-el7
```

### Provision a Vagrant VM using the extra vagrant files
```
ansible-playbook --extra-vars="@../Vagrantsettings.yml" main.yml
# OR:
ansible-playbook --extra-vars="@../Vagrantsettings.local.yml" main.yml
```

### Provision remote preprod hosts
```
ansible-playbook --inventory="inventory.conf" --extra-vars="hosts=preprod" main.yml
```

### Discover information from systems
see: http://docs.ansible.com/ansible/playbooks_variables.html#information-discovered-from-systems-facts
```
ansible all --inventory inventory.conf -m setup
ansible preprod --inventory inventory.conf -m setup
```
