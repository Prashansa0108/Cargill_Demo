resource "aws_security_group" "web-sg" {
    name = "web-sg"
    description = "Allow inbound connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 0
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port       = 0
        to_port         = 0
        cidr_blocks     = ["0.0.0.0/0"]
        protocol        = "-1"
    }
    vpc_id = "${aws_vpc.web-vpc.id}"

    tags = {
        Name = "WebServerSG"
    }
}

resource "aws_instance" "webapp" {
    ami = "${var.ami}"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.web-sg.id}"]
    subnet_id = "${aws_subnet.web-public-subnet.id}"
    associate_public_ip_address = true
    source_dest_check = false
    key_name = "${var.key_name}"
    user_data = "${file("./userdata/web.sh")}"
    tags = {
        Name = "WebServer"
    }
}

