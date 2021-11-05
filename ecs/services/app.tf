data "template_file" "cooking_task_template" {
  template = file("tasks/cooking-app.json")
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "worker"
  container_definitions = data.template_file.cooking_task_template.rendered
}

resource "aws_ecs_service" "cooking_app" {
  name            = "cooking_app"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1
}