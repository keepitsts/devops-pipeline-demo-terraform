#----------Define Terraform Provider----------
provider "aws" {
    region = "us-east-1"
    skip_credentials_validation = true
    profile = "sts-demo"
}


#-----------Create VPC----------
resource "aws_vpc" "vpc" {
  cidr_block       = "${var.vpc_cidr}"

  tags = {
    Name = "${var.env}_vpc"
  }
}

#----------Create subnets----------
resource "aws_subnet" "public_subnet" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.pub_sub}"
  availability_zone = "us-east-1e"

  tags = {
    Name = "${var.env}_public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.priv_sub}"
  availability_zone = "us-east-1f"

  tags = {
    Name = "${var.env}_private_subnet"
  }
}



#----------Create Internet Gateway----------
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.env}_IGW"
  }
}

#----------Create NAT Gateways----------
resource "aws_eip" "ngw_eip" {
    tags = {
        Name = "${var.env}_igw_eip"
    }
}

resource "aws_nat_gateway" "ngw" {
    allocation_id = "${aws_eip.ngw_eip.id}"
    subnet_id = "${aws_subnet.public_subnet.id}"

    tags = {
        Name = "${var.env}_NGW"
    }
}

#----------Create Route Tables and Associations----------
resource "aws_default_route_table" "public_rt" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "${var.env}public_route_table"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "${var.env}_private_route_table"
  }
}

resource "aws_route_table_association" "rt_assoc_pub" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_vpc.vpc.default_route_table_id}"
}

resource "aws_route_table_association" "rt_assoc_priv" {
  subnet_id      = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

#----------Create Secure Service Endpoints----------
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.vpc.id}"
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = ["${aws_vpc.vpc.default_route_table_id}", "${aws_route_table.private_rt.id}"]
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = "${aws_vpc.vpc.id}"
  service_name = "com.amazonaws.us-east-1.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids = ["${aws_vpc.vpc.default_route_table_id}", "${aws_route_table.private_rt.id}"]
}