provider "aws" {
  profile = "${var.profile}"
  region = "${var.region}"
}

data "template_file" "init" {
  template = <<-EOF
  #!/bin/bash -xev

  # Do some chef pre-work
  /bin/mkdir -p /etc/chef
  /bin/mkdir -p /var/lib/chef
  /bin/mkdir -p /var/log/chef

  cd /etc/chef/

  # Copy the organization validator key
  aws s3 cp s3://sts-demo-bucket/simpletechnologysolutions-validator.pem /etc/chef/simpletechnologysolutions-validator.pem

  # Install chef
  curl -L https://omnitruck.chef.io/install.sh | bash || error_exit 'could not install chef'

  # Create client.rb
  /bin/echo 'log_location     STDOUT' >> /etc/chef/client.rb
  /bin/echo -e "chef_server_url  \"https://api.chef.io/organizations/simpletechnologysolutions\"" >> /etc/chef/client.rb
  /bin/echo -e "validation_client_name \"simpletechnologysolutions-validator\"" >> /etc/chef/client.rb
  /bin/echo -e "validation_key \"/etc/chef/simpletechnologysolutions-validator.pem\"" >> /etc/chef/client.rb
  /bin/echo -e "chef_license \"accept\"" >> /etc/chef/client.rb

  sudo chef-client
  EOF
}

resource "aws_instance" "ec2" {
  user_data = "${data.template_file.init.rendered}"
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"

  vpc_security_group_ids = "${var.vpc_security_group_ids}"
  subnet_id = "${var.subnet_id}"

  root_block_device {
    volume_size = "${var.OSDiskSize}"
    volume_type = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "${var.name}"
  }
}

