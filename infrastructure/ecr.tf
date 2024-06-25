resource "aws_ecr_repository" "teste_de_carga_repository" {
  name                 = "teste_de_carga_repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}