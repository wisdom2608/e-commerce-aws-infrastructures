
variable "project_name" {
  description = "Project's Name"
}
variable "environment" {
  description = "Project's Environment"
}

variable "private_database_subnet_az1_id" {
  description = "Private Database Subnet AZ1 id"
}
variable "private_database_subnet_az2_id" {
  description = "Private Database Subnet AZ2 id"
}

variable "db_engine" {
  description = "DB Engine"
}
variable "db_instance_class" {
  description = "DB Instance Class"
}

variable "db_name" {
  description = "DB Name"
}

variable "db_identifier" {
  description = "DB Identifier"
}
variable "admin_login_key" {
  description = "Admin Login Key"

}

variable "db_username" {
  description = "Master username"
}

variable "database_sg_id" {
  description = "Database Seurity Group id"
}

variable "database_az1" {
  description = "Availability Zone for Master Database"
}
