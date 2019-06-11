output "prod_instance_ip" {
  value = "${module.ec2_server.private_ip}"
}
output "prod_instance_id" {
  value = "${module.ec2_server.instance_id}"
}
output "prod_db_endpoint" {
  value = "${module.database.endpoint}"
}