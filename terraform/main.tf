provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "helloworld_cluster" {
  name = "helloworld-cluster"
}

resource "aws_ecs_task_definition" "helloworld" {
  family                   = "helloworld"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name  = "helloworld"
    image = "436728418105.dkr.ecr.us-east-1.amazonaws.com/hello-world-web-app-repo:latest"
    portMappings = [{
      containerPort = 5000
      hostPort      = 5000
    }]
  }])
}

resource "aws_ecs_service" "helloworld_service" {
  name            = "helloworld-service"
  cluster         = aws_ecs_cluster.helloworld_cluster.id
  task_definition = aws_ecs_task_definition.helloworld.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = ["subnet-5235330e", "subnet-ad8ab0ca"] 
    security_groups = ["sg-05c303773d7b1ea2c"]
    assign_public_ip = true
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_attachment" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
