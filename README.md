### Aim:
 *Creating infrastructure for web applications can be done in various ways. The most obvious and straightforward approach is to directly access a cloud service, purchase a server, log in to the server, and install everything required for the application to run. However, this approach doesn't allow for easy scalability and quick recovery of infrastructure after failures. Another approach is to use the infrastructure as code paradigm, where all tasks related to creating and configuring the infrastructure are described using specialized tools. This approach also enforces a strict rule against making changes to the infrastructure without using these tools. This ensures that, in any exceptional situation, engineers can quickly restore the application's functionality because they won't need to recall how the infrastructure was initially set up and configured. Additionally, code that has already been written allows for easy addition or removal of servers and other resources, greatly facilitating scalability as workloads increase.*

**Terraform** *is a powerful tool that enables infrastructure to be described using code. It tracks changes made to the configuration and updates the infrastructure accordingly (deleting or creating resources such as servers, networks, databases, etc.). If certain resources can't be modified, they are recreated. Terraform can work not only with multiple cloud providers but also with other technologies, such as logging, monitoring services, and version control systems (VCS).*

*The installation of necessary applications on prepared servers is performed using **Ansible**. It automates actions on servers, from installing applications to fine-tuning configuration files. Ready-made roles can also be used, which are available on Ansible Galaxy. This significantly speeds up the deployment of infrastructure.*

*The application itself runs in a Docker container. **Docker** allows you to package everything needed for the application (process) to run into an image and run it in isolation from the host system. This prevents conflicts between different application versions and simplifies deployment. Docker has become an industry standard for deploying applications, and most deployment approaches and schemes involve the use of Docker containers*.

### Description:
- *Two web servers with an application (in this project, a ready-made application is used) running inside Docker containers.*
- *A load balancer that receives requests over HTTPS and forwards them to the web servers.*
- *A database as a service.*
- The *ansible/group_vars/all/secret_vars_vault.yml* file contains the credentials for the infrastructure:
  - ``aws_ami_id: "your ami id"``
  - ``aws_key_name: "your aws key"``
  - ``pstg_db_password: "pswd for wiki's db"``
  - ``pstg_db_identifier: "db name for wiki's db"``
  - ``pstg_db_username: "username for wiki's db"``
  - ``datadog_api_key: "api key for datadog"``
  - ``datadog_app_key: "app key for datadog"``
  - ``datadog_api_url: "datadog url"``
It's need to generate the *secret.auto.tfvars* file for Terraform in an automated and secure way and also.
- The path to the private key is in the variable ansible_ssh_private_key_file in the *ansible/group_vars/webservers/vars.yml* directory.

### To start project
Make commands in root folder:
  - ``make init`` - generate the *secret.auto.tfvars* file for Terraform in an automated and secure way, make galaxy install and init terraform (ansilbe-vault password required)
  - ``make deploy`` - to deploy application (ansilbe-vault password required)

### Other commands:
 - ``make init_terraform`` init terraform
 - ``make plan`` - terraform plan
 - ``make apply`` terraform apply
 - ``make format`` terraform frt
 - ``make galaxy_install`` - ansible-galaxy install
 - ``make deploy_ansible`` - ansible deploy
 - ``make deploy_vault`` - ansible deploy with vault password file

### This project is available at https://evgkoch.site

### Hexlet tests and linter status:
[![Actions Status](https://github.com/EvgeniyKoch/devops-for-programmers-project-77/workflows/hexlet-check/badge.svg)](https://github.com/EvgeniyKoch/devops-for-programmers-project-77/actions)
![Upmon Status](https://www.upmon.com/badge/e783c7f8-5749-4160-8747-1472cc/wMk6DASm-2.svg)
