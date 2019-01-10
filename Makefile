run:
	ansible-playbook -v -D --ask-become-pass --connection=local --inventory 127.0.0.1, playbooks/run.yml
