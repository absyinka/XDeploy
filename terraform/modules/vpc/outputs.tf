output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet1_id" {
  value = aws_subnet.subnet1.id
}

output "subnet2_id" {
  value = aws_subnet.subnet2.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.this.id
}

output "public_subnet_1_id" {
  description = "The ID of the public subnet in AZ1"
  value       = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  description = "The ID of the public subnet in AZ2"
  value       = aws_subnet.public_subnet_2.id
}