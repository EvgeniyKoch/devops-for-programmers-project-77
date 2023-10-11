galaxy_install:
	make -C ansible galaxy_install

pip:
	make -C ansible pip

deploy:
	make -C ansible deploy

deploy_vault:
	make -C ansible deploy_vault

plan:
	make -C terraform plan

apply:
	make -C terraform apply

destroy:
	make -C terraform destroy

init:
	make -C terraform init
