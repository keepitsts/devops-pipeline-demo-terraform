variable "profile" {
  description = "aws cli profile/keys to use"
}
variable "region" {
  default = "us-east-1"
}
variable "storage" {
  default = 20
}
variable "engine" {
  default = "mysql"
}
variable "engine_version" {
  default = "5.7"
}
variable "db_instance_class" {
  
}
variable "db_name" {
  
}
variable "db_username" {
  
}
variable "db_password" {
  
}
variable "db_parameter_group" {
  default = "default.mysql5.7"
}
