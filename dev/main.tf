terraform {
  backend "s3" {
    bucket  = "sts-terraform-remote-state"
    key     = "devops_pipeline_demo/dev"
    region  = "us-east-1"
    profile = "sts"
  }
}
module "security_group" {
  source = "../modules/security_group"
  
  profile = "sts"

  sg_name = "dev_security_group"
  sg_description = "Allows access to demo resources"

  vpc_id = "vpc-0e3945d5888632944"

  http_cidr = ["0.0.0.0/0"]
  ssh_cidr = ["0.0.0.0/0"]
}
module "ec2_server" {
    source = "../modules/ec2"

    profile = "sts"
    instance_type = "t3.medium"

    security_groups = ["${module.security_group.id}"]
    subnet_id = "subnet-0a1f8963d08b10d8f"

    name = "dev_server"

    key = "demo_pipeline"
}
# module "database" {
#     source = "../modules/rds"

#     profile = "sts"
#     storage = 20
#     engine = "mysql"
#     engine_version = "5.7"
#     db_subnet_group = "non_prod_subnet_group"
#     db_instance_class = "db.t3.medium"
#     multi_az = false
#     db_name = "devdemodatabase"
#     db_username = "app_user"
#     db_password = "changeme"
# }