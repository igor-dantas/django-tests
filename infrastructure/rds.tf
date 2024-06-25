resource "aws_db_instance" "teste_de_carga_db" {
  allocated_storage    = 10
  db_name              = "teste"
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  username             = "postgres"
  password             = "oaNd5&i4upoYXJ"
  publicly_accessible = true
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.teste_de_carga_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

resource "aws_db_subnet_group" "teste_de_carga_subnet_group" {
  name       = "main"
  subnet_ids = [aws_subnet.subnet_public_1a.id, aws_subnet.subnet_public_1b.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security group for rds"
  vpc_id      = aws_vpc.vpc-ecs-demo.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
