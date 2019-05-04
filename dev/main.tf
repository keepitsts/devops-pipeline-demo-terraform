# TODO create remote state bucket
# terraform {
#   backend "s3" {
#     bucket  = "remote-state"
#     key     = "dev"
#     region  = "us-east-1"
#     profile = "default"
#   }
# }
# TODO update values for actual account
module "ec2_server" {
    source = "../modules/ec2"
    profile = "default"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-9adee2eb"]
    subnet_id = "subnet-c6cb5d9c"
    ami = "ami-0de53d8956e8dcf80"
    name = "dev_server"
}