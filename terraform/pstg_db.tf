resource "aws_db_instance" "pstg_db" {
  identifier             = "education"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "14.3"
  username               = "hexlet"
  password               = "hexletrocks"
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
  host            = "education.cfb6pz3xualn.us-west-2.rds.amazonaws.com"
  port            = 5432
  username        = "hexlet"
  password        = "hexletrocks"
  sslmode         = "require"
  connect_timeout = 15
}

resource "postgresql_database" "education_db" {
  name  = "education"
  owner = "hexlet"
  depends_on = [aws_db_instance.pstg_db]
}
