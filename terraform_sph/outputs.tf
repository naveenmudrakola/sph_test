output "ecs_cluster_arn" {
  description = "The ARN of the deployed ECS cluster."
  value       = module.ecs.ecs_cluster_arn
}

output "ecs_task_definition_arn" {
  description = "The ARN of the ECS task definition."
  value       = module.ecs.ecs_task_definition_arn
}
