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
