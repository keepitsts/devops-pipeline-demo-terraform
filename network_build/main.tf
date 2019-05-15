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

    vpc_cidr    = "192.168.10.0/25"
    env         = "non_prod"
    pub_sub     = "192.168.10.0/26"
    priv_sub    = "192.168.10.64/26"
}

module "testing_network" {
    source = "../modules/network"

    vpc_cidr    = "172.16.10.0/25"
    env         = "testing"
    pub_sub     = "172.16.10.0/26"
    priv_sub    = "172.16.10.64/26"
}

module "prod_network" {
    source = "../modules/network"

    vpc_cidr    = "10.0.10.0/25"
    env         = "prod"
    pub_sub     = "10.0.10.0/26"
    priv_sub    = "10.0.10.64/26"
}




#----------Send current ID info to local file----------
resource "local_file" "networking_ids" {
  filename = "./current_network_ids.txt"
  content = <<-EOF
    Non-Prod:
    VPC ID:               ${module.non_prod_network.vpc-id}
    Public subnet ID:     ${module.non_prod_network.public-subnet-id}
    Private subnet ID:    ${module.non_prod_network.private-subnet-id}

    Testing:
    VPC ID:               ${module.testing_network.vpc-id}
    Public subnet ID:     ${module.testing_network.public-subnet-id}
    Private subnet ID:    ${module.testing_network.private-subnet-id}

    Prod:
    VPC ID:               ${module.prod_network.vpc-id}
    Public subnet ID:     ${module.prod_network.public-subnet-id}
    Private subnet ID:    ${module.prod_network.private-subnet-id}
  
  EOF

} 