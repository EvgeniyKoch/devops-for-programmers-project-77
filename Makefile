init: inst_galaxy gen_secret init_tf
deploy: apply_tf deploy_ans

inst_galaxy:
	make -C ansible install_galaxy

gen_secret:
	make -C ansible generate_secret

run_pip:
	make -C ansible run_pip_tasks

deploy_ans:
	make -C ansible deploy_with_ansible

init_tf:
	make -C terraform initialize_terraform

plan_tf:
	make -C terraform plan_terraform

apply_tf:
	make -C terraform apply_terraform

destroy_tf:
	make -C terraform destroy_terraform

fmt_tf:
	make -C terraform format_terraform
