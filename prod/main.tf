terraform {
  backend "s3" {
    bucket  = "sts-terraform-remote-state"
    key     = "devops_pipeline_demo/prod"
    region  = "us-east-1"
    profile = "sts"
  }
}

module "ec2_server" {
    source = "../modules/ec2"

    profile = "sts"
    instance_type = "t3.medium"

    vpc_security_group_ids = ["sg-9adee2eb"]
    subnet_id = "subnet-c6cb5d9c"

    ami = "ami-0de53d8956e8dcf80"
    name = "dev_server"

    key = "demo_pipeline"
}
module "database" {
    source = "../modules/rds"

    profile = "sts"
    storage = 20
    engine = "mysql"
    engine_version = "5.7"
    db_instance_class = "db.t3.meduim"
    db_name = "demo-db"
    db_username = "app_user"
    db_password = "changeme"
}