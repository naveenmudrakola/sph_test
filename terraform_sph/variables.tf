variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster."
  type        = string
}

variable "task_definition_family" {
  description = "The family of the Task Definition."
  type        = string
}

variable "task_definition_cpu" {
  description = "The CPU value for the Task Definition."
  type        = string
}

variable "task_definition_memory" {
  description = "The memory value for the Task Definition."
  type        = string
}

variable "container_image" {
  description = "The image for the container definition."
  type        = string
}

variable "container_port" {
  description = "The container port for the container definition."
  type        = number
}

variable "host_port" {
  description = "The host port for the container definition."
  type        = number
}

variable "ecs_service_desired_count" {
  description = "Desired count of services in the ECS cluster."
  type        = number
}

variable "network_subnets" {
  description = "List of subnets for the network configuration."
  type        = list(string)
}

variable "security_groups" {
  description = "List of security groups for the network configuration."
  type        = list(string)
}

variable "iam_role_name" {
  description = "Name of the IAM role for ECS."
  type        = string
}
