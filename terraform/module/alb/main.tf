# ---------------------------------------------------------------------------------------------------------------------
# LOAD BALANCER (SH-Airflow)
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_alb" "airflow-alb" {
  name            = "sh-airflow-${var.environment}-alb"
  subnets         = var.public_subnet_ids
  security_groups = [aws_security_group.airflow-alb-sg.id]
  enable_deletion_protection = true
  access_logs {
    bucket  = var.access_logs_bucket
    prefix  = "airflow-alb"
    enabled = true
  }
  tags = {
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "airflow-alb-tg" {
  name                 = "sh-airflow-${var.environment}-alb-tg"
  port                 = 80
  protocol             = "HTTP"
  target_type = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay

  health_check {
    path     = var.airflow_health_check_path
    protocol = "HTTP"
    interval = 60
    timeout = 30
    healthy_threshold = 5
    unhealthy_threshold = 5
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_alb_listener" "airflow_http" {
  load_balancer_arn = aws_alb.airflow-alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      status_code = "HTTP_301"
      port        = "443"
      protocol    = "HTTPS"
    }
  }
}

resource "aws_alb_listener" "airflow_listener_ssl" {
  load_balancer_arn = aws_alb.airflow-alb.id
  port              = "443"
  protocol          = "HTTPS"
  depends_on        = [aws_alb_target_group.airflow-alb-tg]
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.alb_certificate_arn 
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Page is Forbidden"
      status_code  = "403"
    }
  }
}

resource "aws_lb_listener_rule" "airflow_rule_1" {
  listener_arn = aws_alb_listener.airflow_listener_ssl.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.airflow-alb-tg.arn
  }

  condition {
    path_pattern {
      values = ["/dataset/*", "/evidence", "/evidence/*", "/vex/*", "/api/github/hook"]
    }
  }
}

resource "aws_lb_listener_rule" "airflow_rule_2" {
  listener_arn = aws_alb_listener.airflow_listener_ssl.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.airflow-alb-tg.arn
  }

  condition {
    path_pattern {
      values = ["/internal/*"]
    }
  }
  condition {
    source_ip {
      values = [var.vpc_ng1_cidr, var.vpc_ng2_cidr]
    }
  }
}

resource "aws_lb_listener_rule" "airflow_rule_3" {
  listener_arn = aws_alb_listener.airflow_listener_ssl.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.airflow-alb-tg.arn
  }

  condition {
    path_pattern {
      values = ["/v1/*", "/v2/*", "/syslog", "/dataset"]
    }
  }
}

resource "aws_security_group" "airflow-alb-sg" {
  name   = "sh-airflow-${var.environment}-alb-sg"
  vpc_id = var.vpc_id

  tags = {
    Environment = var.environment
  }
}

resource "aws_security_group_rule" "airflow_http_from_anywhere" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.airflow-alb-sg.id
}

resource "aws_security_group_rule" "airflow_https_from_anywhere" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.airflow-alb-sg.id
}

resource "aws_security_group_rule" "airflow_outbound_internet_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.airflow-alb-sg.id
}

resource "aws_route53_record" "airflow_route53_record" {
  depends_on = [
    aws_alb.airflow-alb
  ]

  zone_id = var.zone_id
  name    = "airflow"
  type    = "A"

    alias {
      name    = aws_alb.airflow-alb.dns_name
      zone_id = aws_alb.airflow-alb.zone_id
      evaluate_target_health = true
    }
}