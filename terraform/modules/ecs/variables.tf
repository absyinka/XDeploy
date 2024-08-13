variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "family" {
  description = "The family of the ECS task definition"
  type        = string
}

variable "cpu" {
  description = "The CPU units to allocate for the task"
  type        = string
}

variable "memory" {
  description = "The amount of memory to allocate for the task"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the execution role"
  type        = string
}

variable "container_definitions" {
  description = "The container definitions JSON"
  type        = string
}

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "desired_count" {
  description = "The desired number of service tasks"
  type        = number
}

variable "subnets" {
  description = "A list of subnet IDs for the ECS service"
  type        = list(string)
}

variable "security_groups" {
  description = "A list of security group IDs for the ECS service"
  type        = list(string)
}
