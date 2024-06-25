resource "aws_vpc" "vpc-ecs-demo" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames    = true
  enable_dns_support      = true
  tags = {
    Name = "vpc-ecs-demo"
  }
}


##############################################
############## PUBLIC ########################
##############################################

resource "aws_subnet" "subnet_public_1a" {
  vpc_id            = aws_vpc.vpc-ecs-demo.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-public-ecs-demo-a"
  }
}

resource "aws_subnet" "subnet_public_1b" {
  vpc_id            = aws_vpc.vpc-ecs-demo.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-public-ecs-demo-b"
  }
}

resource "aws_internet_gateway" "igw-ecs-demo" {
  vpc_id = aws_vpc.vpc-ecs-demo.id
  tags = {
    Name = "igw-ecs-demo"
  }
}

resource "aws_route_table" "rtb-public-ecs-demo" {
  vpc_id = aws_vpc.vpc-ecs-demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-ecs-demo.id
  }

  tags = {
    Name = "rtb-public-ecs-demo"
  }
}

resource "aws_route_table_association" "public_subnet_assoc_a" {
  subnet_id      = aws_subnet.subnet_public_1a.id
  route_table_id = aws_route_table.rtb-public-ecs-demo.id
}

resource "aws_route_table_association" "public_subnet_assoc_b" {
  subnet_id      = aws_subnet.subnet_public_1b.id
  route_table_id = aws_route_table.rtb-public-ecs-demo.id
}

