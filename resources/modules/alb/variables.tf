variable "project_name" {
  description = "Project's Name"
}

variable "public_subnet_az1_id" {
  description = "Public Subnet AZ1 id"
}

variable "public_subnet_az2_id" {
  description = "Public Subnet AZ2 id"
}

variable "environment" {
  description = "Project's Environment"
}

variable "appserver-1_id" {
  description = "Appserver-1 id"
}

variable "appserver-2_id" {
  description = "appserver-2 id"
}

variable "alb_sg_id" {
  description = "Application Load Balancer Security Group"
}
variable "vpc_id" {
  description = "VPC ID"
}