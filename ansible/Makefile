install_galaxy:
	ansible-galaxy install -r requirements.yml

generate_secret:
	ansible-playbook --ask-vault-pass prepare_tf_vars_playbook.yml

run_pip_tasks:
	ansible-playbook --check playbook.yml -i inventory.yml -t pip

run_datadog_tasks:
	ansible-playbook --check playbook.yml -i inventory.yml -t datadog --ask-vault-pass

deploy_with_ansible:
	ansible-playbook -i inventory.yml --ask-vault-pass playbook.yml -t deploy
