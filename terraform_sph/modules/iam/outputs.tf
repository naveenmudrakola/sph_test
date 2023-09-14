output "execution_role_arn" {
  description = "The ARN of the ECS execution IAM role."
  value       = aws_iam_role.ecs_execution_role.arn
}
