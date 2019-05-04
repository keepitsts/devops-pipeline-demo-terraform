variable "profile" {
  description = "aws cli profile/keys to use"
}
variable "region" {
  default = "us-east-1"
}
variable "ami" {
  
}
variable "instance_type" {
  default = "t3.micro"
}
variable "vpc_security_group_ids" {
  type = "list"
}
variable "subnet_id" {
  
}
variable "OSDiskSize" {
  default = "8"
}
variable "name" {
  
}
