resource "aws_lb" "my_lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    =  [aws_security_group.lb_sg.id]
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
  vpc_id   = data.aws_vpc.default.id

  health_check {
    enabled = true
    path    = "/"
    port    = "80"
  }
}

resource "aws_lb_target_group_attachment" "web_server_tg_attachment" {
  count             = 2
  target_group_arn  = aws_lb_target_group.my_lb_tg.arn
  target_id         = aws_instance.web_servers[count.index].id
  port              = 80
}

