provider "aws" {
  profile = "${var.profile}"
  region = "${var.region}"
}
resource "aws_db_instance" "db" {
  allocated_storage    = "${var.storage}"
  storage_type         = "gp2"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  instance_class       = "${var.db_instance_class}"
  name                 = "${var.db_name}"
  username             = "${var.db_username}"
  password             = "${var.db_password}"
  parameter_group_name = "${var.db_parameter_group}"
}