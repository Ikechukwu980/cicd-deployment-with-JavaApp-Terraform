#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#  * Security Group
#  * Flow Log
#

resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform-eks-demo-node"
  }
}

resource "aws_subnet" "demo" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.demo.id

  tags = {
    Name = "terraform-eks-demo-node"
  }
}

resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "terraform-eks-demo"
  }
}

resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo.id
  }
}

resource "aws_route_table_association" "demo" {
  count = 2

  subnet_id      = aws_subnet.demo[count.index].id
  route_table_id = aws_route_table.demo.id
}

resource "aws_security_group" "demo" {
  vpc_id = aws_vpc.demo.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-demo"
  }
}

# resource "aws_flow_log" "demo" {
#   count             = length(aws_vpc.demo.*.id)
#   log_destination   = "arn:aws:logs:us-west-2:220894557754:log-group:/vpc-flow-logs"
#   log_destination_type = "cloud-watch-logs"
#   traffic_type      = "ALL"
#   vpc_id            = aws_vpc.demo.id
# }
