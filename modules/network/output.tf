output "vpc-id" {
    value = "${aws_vpc.vpc.id}"
}

output "public-subnet-id-1" {
    value = "${aws_subnet.public_subnet-1.id}"
}

output "public-subnet-id-2" {
    value = "${aws_subnet.public_subnet-2.id}"
}

output "private-subnet-id-1" {
    value = "${aws_subnet.private_subnet-1.id}"
}

output "private-subnet-id-2" {
    value = "${aws_subnet.private_subnet-2.id}"
}

output "rds-subgroup-id" {
    value = "${aws_db_subnet_group.subnet_group.id}"
}