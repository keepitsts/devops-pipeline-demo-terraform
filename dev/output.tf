output "instance_ip" {
  value = "${module.ec2_server.private_ip}"
}
output "instance_id" {
  value = "${module.ec2_server.instance_id}"
}
# output "db_endpoint" {
#   value = "${module.database.endpoint}"
# }
