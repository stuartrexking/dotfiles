run:
	ansible-playbook -v -D -i inventory --ask-sudo-pass playbooks/osx.yml
