init: galaxy_install generate_secret init_terraform
deploy: apply deploy_ansible

galaxy_install:
	make -C ansible galaxy_install

generate_secret:
	make -C ansible generate_secret

pip:
	make -C ansible pip

deploy_ansible:
	make -C ansible deploy

deploy_vault:
	make -C ansible deploy_vault

init_terraform:
	make -C terraform init

plan:
	make -C terraform plan

apply:
	make -C terraform apply

destroy:
	make -C terraform destroy

format:
	make -C terraform format
