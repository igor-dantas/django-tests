resource "aws_ecs_cluster" "ecs-cluster-demo" {
  name = "ecs-cluster-demo"
}

resource "aws_ecs_cluster_capacity_providers" "ecs-capacity_provider-demo" {
  cluster_name = aws_ecs_cluster.ecs-cluster-demo.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "task-definition-demo" {
  family                   = "task-definition-demo"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name      = "task-definition-demo"
      image     = "542416788422.dkr.ecr.us-east-1.amazonaws.com/teste_de_carga_repository:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "service-ecs-demo" {
  name            = "service-ecs-demo"
  cluster         = aws_ecs_cluster.ecs-cluster-demo.id
  task_definition = aws_ecs_task_definition.task-definition-demo.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-tg-demo.arn
    container_name   = "task-definition-demo"
    container_port   = 8000
  }

  network_configuration {
    subnets         = [aws_subnet.subnet_public_1a.id, aws_subnet.subnet_public_1b.id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }


  depends_on = [
    aws_lb.alb,
    aws_lb_target_group.ecs-tg-demo,
    aws_lb_listener.http
  ]
}


resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "Security group for ECS"
  vpc_id      = aws_vpc.vpc-ecs-demo.id

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
