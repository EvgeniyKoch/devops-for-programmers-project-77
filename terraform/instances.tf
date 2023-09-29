resource "aws_instance" "web_servers" {
  count         = 2
  ami           = "ami-05c9a95d305c1f5a3"
  instance_type = "t2.micro"
  key_name      = "MyAWSKey"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "WebServer-${count.index + 1}"
  }
}
