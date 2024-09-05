output "airflow_alb_sg_id" {
  value = aws_security_group.airflow-alb-sg.id
}

output "airflow_alb_tg" {
  value = aws_alb_target_group.airflow-alb-tg.arn
}

output "airflow_alb_dns_name" {
  value = aws_alb.airflow-alb.dns_name
}

output "airflow_alb" {
  value = aws_alb.airflow-alb
}
