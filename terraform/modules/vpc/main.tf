resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet1_cidr_block
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet2_cidr_block
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.20.0/24"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

  lifecycle {
    ignore_changes = [
      destination_cidr_block,
      gateway_id,
    ]
  }
}

resource "aws_route_table_association" "subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public.id
}
