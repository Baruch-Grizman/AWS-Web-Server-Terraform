# deploy an AWS VPC with Terraform
resource "aws_vpc" "artac_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "artac"
  }
}

# reference the VPC resource to create an AWS subnet resource, to which we can deploy our future EC2 instance
resource "aws_subnet" "artac_public_subnet" {
  vpc_id                  = aws_vpc.artac_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "artac-public"
  }
}

# deploy an AWS Internet Gateway
resource "aws_internet_gateway" "artac_internet_gateway" {
  vpc_id = aws_vpc.artac_vpc.id

  tags = {
    Name = "artac-igw"
  }
}

# deploy an AWS Route Table with Terraform, to route traffic from our subnet to our internet gateway
resource "aws_route_table" "artac_public_rt" {
  vpc_id = aws_vpc.artac_vpc.id

  tags = {
    Name = "artac-public-rt"
  }
}

# we need to configure all traffic to get to the internet
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.artac_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.artac_internet_gateway.id
}

# Provides a resource to create an association between a route table and a subnet or a route table and an internet gateway or virtual private gateway
resource "aws_route_table_association" "tfc_public_assoc" {
  subnet_id      = aws_subnet.artac_public_subnet.id
  route_table_id = aws_route_table.artac_public_rt.id
}

# deploy an AWS EC2 Key Pair with Terraform
resource "aws_key_pair" "artac_auth" {
  key_name   = "artackey"
  public_key = file("~/.ssh/artackey.pub")
}

# start deploying an EC2 Instance with Terraform
resource "aws_instance" "artac_node" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.artac_auth.id
  vpc_security_group_ids = [aws_security_group.artac_sg.id]
  subnet_id              = aws_subnet.artac_public_subnet.id
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "artac-node"
  }
}
