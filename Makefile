run:
	ansible-playbook -v -D -K --connection=local --inventory 127.0.0.1, playbooks/run.yml 
