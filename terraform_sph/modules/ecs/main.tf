resource "aws_ecs_cluster" "sph_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "sph" {
  family                   = var.task_definition_atts.family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_definition_atts.cpu
  memory                   = var.task_definition_atts.memory
  execution_role_arn       = var.execution_role_arn
  container_definitions = jsonencode([{
    name  = var.task_definition_atts.family
    image = var.container_def_image
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.host_port
    }]
  }])
}

resource "aws_ecs_service" "sph_service" {
  name            = "${var.ecs_cluster_name}-service"
  cluster         = aws_ecs_cluster.sph_cluster.id
  task_definition = aws_ecs_task_definition.sph.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
    assign_public_ip = true
  }
}
