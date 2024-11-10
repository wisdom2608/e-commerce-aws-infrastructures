
output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}
output "project_name" {
  value = var.project_name
}

output "environment" {
  value = var.environment
}


output "public-route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.igw
}
output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az2.id
}

output "private_app_subnet_az1_id" {
  value = aws_subnet.private_app_subnet_az1.id
}

output "private_app_subnet_az2_id" {
  value = aws_subnet.private_app_subnet_az2.id
}

output "private_database_subnet_az1_id" {
  value = aws_subnet.private_database_subnet_az1.id
}

output "private_database_subnet_az2_id" {
  value = aws_subnet.private_database_subnet_az2.id
}