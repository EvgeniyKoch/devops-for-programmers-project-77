galaxy_install:
	ansible-galaxy install -r requirements.yml

pip:
	ansible-playbook --check playbook.yml -i inventory.yml -t pip

datadog:
	ansible-playbook --check playbook.yml -i inventory.yml -t datadog

deploy:
	ansible-playbook -i inventory.yml --ask-vault-pass playbook.yml

deploy_vault:
	ansible-playbook -i inventory.yml --vault-password-file vault_password playbook.yml

