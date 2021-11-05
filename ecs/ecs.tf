#Creates  ECS 

resource "aws_ecs_cluster" "ecs_cluster" {
    name = "My cluster"
}