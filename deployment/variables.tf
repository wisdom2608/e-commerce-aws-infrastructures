variable "region" {
}

variable "project_name" {
  description = "Project's name"
}

variable "environment" {
  description = "Project's Environment"
}

variable "vpc_cidr" {
  description = "vpc id"
}

variable "az1" {
  description = "First Availability Zone"

}
variable "az2" {
  description = "Second Availability Zone"
}

variable "public_subnet_az1_cidr" {
  description = "Public Subnet AZ1 CIDR"
}
variable "public_subnet_az2_cidr" {
  description = "Public Subnet AZ2 CIDR"
}

variable "private_app_subnet_az1_cidr" {
  description = "Private Subnet AZ1 CIDR block"
}

variable "private_app_subnet_az2_cidr" {
  description = "Private Subnet AZ2 CIDR block"
}

variable "private_database_subnet_az1_cidr" {
  description = "Private DB Subnet AZ1 CIDR Block"
}

variable "private_database_subnet_az2_cidr" {
  description = "Private DB Subnet AZ2 CIDR Block"
}

variable "myip_address" {
  description = "My IP Address"
}

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

variable "appserver_name" {
  description = "App Server Name"
}

variable "webserver_name" {
  description = "Web Server Name"
}

variable "db_engine" {
  description = "DB Engine"
}
variable "db_instance_class" {
  description = "DB Instance Class"
}
variable "db_identifier" {
  description = "DB Identifier"
}

variable "db_name" {
  description = "DB Name"
}
variable "db_username" {
  description = "Master username"
}

variable "admin_login_key" {
  description = "Admin Login Key"

}

variable "database_az1" {
  description = "Availability Zone for Master Database"
}
