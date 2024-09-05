data "aws_ecs_task_definition" "mongo" {
  task_definition = aws_ecs_task_definition.mongo.family
}

resource "aws_ecs_cluster" "ecs-medusa" {
  name = "Me_d_usa"
}

resource "aws_ecs_task_definition" "mongo" {
  family = "mongodb"

  container_definitions = <<DEFINITION
[
  {
    "cpu": 128,
    "environment": [{
      "name": "SECRET",
      "value": "KEY"
    }],
    "essential": true,
    "image": "mongo:latest",
    "memory": 128,
    "memoryReservation": 64,
    "name": "mongodb"
  }
]
DEFINITION
}

resource "aws_ecs_service" "medusajs" {
  name          = "medusajs"
  cluster       = aws_ecs_cluster.ecs-medusa.id
  desired_count = 1

  # Track the latest ACTIVE revision
  task_definition = data.aws_ecs_task_definition.mongo.arn
}