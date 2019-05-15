output "test_instance_ip" {
  value = "${module.ec2_server.private_ip}"
}
output "test_instance_id" {
  value = "${module.ec2_server.instance_id}"
}
output "test_db_endpoint" {
  value = "${module.database.endpoint}"
}