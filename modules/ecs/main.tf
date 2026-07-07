variable "vpc_id" {}
variable "public_subnet_id" {}
variable "env" {}

resource "aws_lb" "alb" {
  name               = "${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.public_subnet_id]
}

resource "aws_ecs_cluster" "main" {
  name = "${var.env}-ecs-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.env}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([{
    name      = "app"
    image     = "nginx:alpine"
    essential = true
    portMappings = [{ containerPort = 80, hostPort = 80 }]
  }])
}

resource "aws_ecs_service" "main" {
  name            = "${var.env}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets = [var.public_subnet_id]
  }
}
