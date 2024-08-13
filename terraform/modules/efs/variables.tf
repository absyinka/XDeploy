variable "creation_token" {
  description = "The creation token for the EFS file system"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the mount target will be created"
  type        = string
}

variable "security_groups" {
  description = "A list of security group IDs for the EFS mount target"
  type        = list(string)
}
