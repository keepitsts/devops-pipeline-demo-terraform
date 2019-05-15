provider "aws" {
  profile = "${var.profile}"
  region = "${var.region}"
}
resource "aws_instance" "server" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"

  key_name = "${var.key}"

  vpc_security_group_ids = "${var.vpc_security_group_ids}"
  subnet_id = "${var.subnet_id}"

  # iam_instance_profile = "${var.role}"

  root_block_device {
    volume_size = "${var.OSDiskSize}"
    volume_type = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "${var.name}"
  }
}

