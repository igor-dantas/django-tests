output "dns_load_balancer" {
  value = aws_lb.alb.dns_name
}

output "repository_name"{
  value = aws_ecr_repository.teste_de_carga_repository.repository_url
}

output "endpoint_rds"{
  value = aws_db_instance.teste_de_carga_db.endpoint
}