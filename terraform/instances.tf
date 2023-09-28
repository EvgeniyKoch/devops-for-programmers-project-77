resource "aws_instance" "web_servers" {
  count         = 2
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "WebServer-${count.index + 1}"
  }
}
