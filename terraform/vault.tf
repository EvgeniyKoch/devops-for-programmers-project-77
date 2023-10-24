resource "local_file" "CredentialsTmp" {
  filename = "${path.module}/../ansible/group_vars/webservers/vault"
  content  = <<-EOT
    wiki_db_host: ${element(split(":", aws_db_instance.postgres_db.endpoint), 0)}
    wiki_db_type: ${aws_db_instance.postgres_db.engine}
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
