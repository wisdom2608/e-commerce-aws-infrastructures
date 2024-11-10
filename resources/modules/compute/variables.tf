variable "filename" {
  description = "EC2 Key Pair File Name"
}

variable "ami" {
  description = "EC2 Instance AMI"
}

variable "instance_type" {
  description = "EC2 Instance Type"
}

variable "key_name" {
  description = "EC2 Key Pair Name"
}

variable "environment" {
  description = "Project's Environment"
}

variable "public_subnet_az1_id" {
  description = " Public Subnet ID For AZ1"
}

# variable "public_subnet_az2_id" {
#   description = " Public Subnet ID For AZ2"
# }


variable "private_app_subnet_az1_id" {
  description = "Private App Subnets AZ1 ID"
}

variable "private_app_subnet_az2_id" {
  description = "Private App Subnets AZ2 ID"
}

variable "ssh_sg_id" {
  description = "Application Load Balancer Security Group"
}
variable "app_server_sg_id" {
  description = "App Server Security Group"
}

variable "appserver_name" {
  description = "App Server Name"
}

variable "webserver_name" {
  description = "Web Server Name"
}
