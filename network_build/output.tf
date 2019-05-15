output "non-prod-vpc-id" {
    value = "${module.non_prod_network.vpc-id}"
}

output "non-prod-public-subnet-id" {
    value = "${module.non_prod_network.public-subnet-id}"
}

output "non-prod-private-subnet-id" {
    value = "${module.non_prod_network.private-subnet-id}"
}

output "testing-vpc-id" {
    value = "${module.testing_network.vpc-id}"
}

output "testing-public-subnet-id" {
    value = "${module.testing_network.public-subnet-id}"
}

output "testing-private-subnet-id" {
    value = "${module.testing_network.private-subnet-id}"
}

output "prod-vpc-id" {
    value = "${module.prod_network.vpc-id}"
}

output "prod-public-subnet-id" {
    value = "${module.prod_network.public-subnet-id}"
}

output "prod-private-subnet-id" {
    value = "${module.prod_network.private-subnet-id}"
}