variable "ecs_cluster_name" {
  description = "Name of the ECS cluster."
  type        = string
}

variable "task_definition_atts" {
  description = "Attributes for the Task Definition like family, CPU, and memory."
  type        = map(string)
}

variable "container_def_image" {
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

variable "desired_count" {
  description = "Desired count of services in the ECS cluster."
  type        = number
}

variable "subnets" {
  description = "List of subnets for the network configuration."
  type        = list(string)
}

variable "security_groups" {
  description = "List of security groups for the network configuration."
  type        = list(string)
}

variable "execution_role_arn" {
  description = "The ARN of the ECS execution role."
  type        = string
}
