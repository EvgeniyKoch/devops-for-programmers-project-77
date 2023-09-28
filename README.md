### Aim:
 *Creating infrastructure for web applications can be done in various ways. The most obvious and straightforward approach is to directly access a cloud service, purchase a server, log in to the server, and install everything required for the application to run. However, this approach doesn't allow for easy scalability and quick recovery of infrastructure after failures. Another approach is to use the infrastructure as code paradigm, where all tasks related to creating and configuring the infrastructure are described using specialized tools. This approach also enforces a strict rule against making changes to the infrastructure without using these tools. This ensures that, in any exceptional situation, engineers can quickly restore the application's functionality because they won't need to recall how the infrastructure was initially set up and configured. Additionally, code that has already been written allows for easy addition or removal of servers and other resources, greatly facilitating scalability as workloads increase.*

**Terraform** *is a powerful tool that enables infrastructure to be described using code. It tracks changes made to the configuration and updates the infrastructure accordingly (deleting or creating resources such as servers, networks, databases, etc.). If certain resources can't be modified, they are recreated. Terraform can work not only with multiple cloud providers but also with other technologies, such as logging, monitoring services, and version control systems (VCS).*

*The installation of necessary applications on prepared servers is performed using **Ansible**. It automates actions on servers, from installing applications to fine-tuning configuration files. Ready-made roles can also be used, which are available on Ansible Galaxy. This significantly speeds up the deployment of infrastructure.*

*he application itself runs in a Docker container. **Docker** allows you to package everything needed for the application (process) to run into an image and run it in isolation from the host system. This prevents conflicts between different application versions and simplifies deployment. Docker has become an industry standard for deploying applications, and most deployment approaches and schemes involve the use of Docker containers*.

### Description:
- *Two web servers with an application (in this project, a ready-made application is used) running inside Docker containers.*
- *A load balancer that receives requests over HTTPS and forwards them to the web servers.*
- *A database as a service.*


### Hexlet tests and linter status:
[![Actions Status](https://github.com/EvgeniyKoch/devops-for-programmers-project-77/workflows/hexlet-check/badge.svg)](https://github.com/EvgeniyKoch/devops-for-programmers-project-77/actions)
