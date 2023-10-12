resource "local_file" "AnsibleInventory" {
  filename = "${path.module}/../ansible/inventory.yml"
  content = <<-EOT
    all:
      children:
        webservers:
          vars:
            ansible_ssh_user: ubuntu
          hosts:
            WebServer1:
              ansible_host: ${aws_instance.web_servers[0].public_ip}
            WebServer2:
              ansible_host: ${aws_instance.web_servers[1].public_ip}
  EOT
}
