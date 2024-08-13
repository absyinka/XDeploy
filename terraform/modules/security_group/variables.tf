variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "from_port" {
  description = "The starting port"
  type        = number
}

variable "to_port" {
  description = "The ending port"
  type        = number
}

variable "cidr_blocks" {
  description = "A list of allowed CIDR blocks"
  type        = list(string)
}
