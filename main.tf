resource "aws_vpc" "web-vpc" {
  cidr_block = "20.0.0.0/16"
  tags = {
    Name = "web-vpc"
  }
}
resource "aws_internet_gateway" "web-igw" {
  vpc_id = "${aws_vpc.web-vpc.id}"
  tags = {
    Name = "web-igw"
  }
}

resource "aws_subnet" "web-public-subnet" {
  vpc_id       = "${aws_vpc.web-vpc.id}"
  cidr_block   = "20.0.1.0/24"
  tags = {
    Name = "web-public"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.web-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.web-igw.id}"
}

resource "aws_route_table" "web-route-table" {
    vpc_id = "${aws_vpc.web-vpc.id}"
     route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.web-igw.id}"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
    subnet_id      = "${aws_subnet.web-public-subnet.id}"
    route_table_id = "${aws_route_table.web-route-table.id}"
}

resource "aws_eip" "web-eip" {
    vpc      = true
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "${aws_vpc.web-vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  egress {
    from_port       = 0
    to_port         = 0
    cidr_blocks     = ["0.0.0.0/0"]
    protocol        = "-1"
  }
}

resource "aws_codecommit_repository" "demo-repo" {
  repository_name = "MyDemoRepository"
  description     = "This is the Demo App Repository"

  tags = {
    Owner       = "DevOps Team"
    Environment = "Dev"
    Terraform   = true
  }

}