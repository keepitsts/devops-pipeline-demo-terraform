terraform {
  backend "s3" {
    bucket  = "sts-terraform-remote-state"
    key     = "devops_pipeline_demo/db"
    region  = "us-east-1"
    profile = "sts"
  }
}
module "database" {
    source = "../modules/rds"

    profile = "sts"
    storage = 20
    engine = "mysql"
    engine_version = "5.7"
    db_subnet_group = "non_prod_subnet_group"
    db_instance_class = "db.t3.medium"
    multi_az = false
    db_name = "demodatabase"
    db_username = "app_user"
    db_password = "changeme"
}