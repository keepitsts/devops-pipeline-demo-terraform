#----------Configure S3 remote state----------
terraform {
    backend "s3" {
        bucket = "sts-terraform-remote-state"
        key = "network/demo-networking-tfstate"
        region = "us-east-1"
        profile = "sts-demo"
    }
}

module "non_prod_network" {
    source = "../modules/network"

    vpc_cidr    = "192.168.10.0/24"
    env         = "non_prod"
    pub_sub-1   = "192.168.10.0/26"
    pub_sub-2   = "192.168.10.64/26"
    priv_sub-1  = "192.168.10.128/26"
    priv_sub-2  = "192.168.10.192/26"
}

module "testing_network" {
    source = "../modules/network"

    vpc_cidr    = "172.16.10.0/24"
    env         = "testing"
    pub_sub-1   = "172.16.10.0/26"
    pub_sub-2   = "172.16.10.64/26"
    priv_sub-1  = "172.16.10.128/26"
    priv_sub-2  = "172.16.10.192/26"
}

module "prod_network" {
    source = "../modules/network"

    vpc_cidr    = "10.0.10.0/24"
    env         = "prod"
    pub_sub-1   = "10.0.10.0/26"
    pub_sub-2   = "10.0.10.64/26"
    priv_sub-1  = "10.0.10.128/26"
    priv_sub-2  = "10.0.10.192/26"
}




#----------Send current ID info to local file----------
resource "local_file" "networking_ids" {
  filename = "./current_network_ids.txt"
  content = <<-EOF
    Non-Prod:
    VPC ID:                 ${module.non_prod_network.vpc-id}
    Public subnet-1 ID:     ${module.non_prod_network.public-subnet-id-1}
    Public subnet-2 ID:     ${module.non_prod_network.public-subnet-id-2}
    Private subnet-1 ID:    ${module.non_prod_network.private-subnet-id-1}
    Private subnet-2 ID:    ${module.non_prod_network.private-subnet-id-2}
    RDS subnet group ID:    ${module.non_prod_network.rds-subgroup-id}

    Testing:
    VPC ID:                 ${module.testing_network.vpc-id}
    Public subnet-1 ID:     ${module.testing_network.public-subnet-id-1}
    Public subnet-2 ID:     ${module.testing_network.public-subnet-id-2}
    Private subnet-1 ID:    ${module.testing_network.private-subnet-id-1}
    Private subnet-2 ID:    ${module.testing_network.private-subnet-id-2}
    RDS subnet group ID:    ${module.testing_network.rds-subgroup-id}

    Prod:
    VPC ID:                 ${module.prod_network.vpc-id}
    Public subnet-1 ID:     ${module.prod_network.public-subnet-id-1}
    Public subnet-2 ID:     ${module.prod_network.public-subnet-id-2}
    Private subnet-1 ID:    ${module.prod_network.private-subnet-id-1}
    Private subnet-2 ID:    ${module.prod_network.private-subnet-id-2}
    RDS subnet group ID:    ${module.prod_network.rds-subgroup-id}
  
  EOF

} 