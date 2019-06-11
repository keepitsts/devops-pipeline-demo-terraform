provider "aws" {
  profile = "${var.profile}"
  region = "${var.region}"
}
resource "aws_db_instance" "db" {
  identifier           = "${var.db_name}"
  allocated_storage    = "${var.storage}"
  storage_type         = "gp2"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  db_subnet_group_name = "${var.db_subnet_group}"
  instance_class       = "${var.db_instance_class}"
  multi_az             = "${var.multi_az}"
  name                 = "${var.db_name}"
  username             = "${var.db_username}"
  password             = "${var.db_password}"
  parameter_group_name = "${var.db_parameter_group}"
  skip_final_snapshot = true 
  # No significant data should be stored in demo resources
}