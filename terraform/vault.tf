resource "local_file" "CredentialsTmp" {
  filename = "${path.module}/../ansible/group_vars/webservers/vault"
  content  = <<-EOT
    wiki_db_host: ${element(split(":", aws_db_instance.pstg_db.endpoint), 0)}
    wiki_db_port: ${aws_db_instance.pstg_db.port}
    wiki_db_user: ${aws_db_instance.pstg_db.username}
    wiki_db_pass: ${aws_db_instance.pstg_db.password}
    wiki_db_name: ${var.pstg_db_identifier}
    wiki_db_type: ${aws_db_instance.pstg_db.engine}
    datadog_key: ${var.datadog_api_key}
    datadog_api_url: ${var.datadog_api_url}
  EOT
}

resource "null_resource" "EncryptVault" {
  depends_on = [local_file.CredentialsTmp]

  provisioner "local-exec" {
    command = "ansible-vault encrypt ${path.module}./ansible/group_vars/webservers/vault --vault-password-file=${path.module}./ansible/vault_password"
  }

  triggers = {
    always_run = timestamp()
  }
}
