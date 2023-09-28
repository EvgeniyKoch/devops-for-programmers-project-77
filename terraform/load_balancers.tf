resource "aws_lb" "my_lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = ["subnet-0c1c60c609838f5b1", "subnet-0332ed37372bda340", "subnet-0d9b3143117f842f7", "subnet-09bfe6229e45c7875"]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "client" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_lb_tg.arn
  }
}

resource "aws_lb_target_group" "my_lb_tg" {
  name     = "my-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-05fddca804d444bc4"

  health_check {
    enabled = true
    path    = "/"
    port    = "80"
  }
}
