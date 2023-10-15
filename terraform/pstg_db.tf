resource "aws_db_instance" "pstg_db" {
  identifier             = var.pstg_db_identifier
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "14.7"
  username               = var.pstg_db_username
  password               = var.pstg_db_password
  parameter_group_name   = aws_db_parameter_group.education.name
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

resource "aws_db_parameter_group" "education" {
  name   = "postgres-params"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

provider "postgresql" {
  host            = element(split(":", aws_db_instance.pstg_db.endpoint), 0)
  port            = var.pstg_db_port
  username        = aws_db_instance.pstg_db.username
  password        = aws_db_instance.pstg_db.password
  sslmode         = "require"
  connect_timeout = 15
}


resource "postgresql_database" "education_db" {
  name       = var.pstg_db_identifier
  owner      = var.pstg_db_username
  depends_on = [aws_db_instance.pstg_db]
}
