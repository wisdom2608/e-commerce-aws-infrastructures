resource "aws_vpc_endpoint" "vpc-endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.us-east-2.s3"
  vpc_endpoint_type = "Gateway"
  tags = {
    Name = "${var.project_name}-vpc-ept"
    env : var.environment
  }
}

resource "aws_vpc_endpoint_route_table_association" "example" {
  route_table_id  = var.public-route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.vpc-endpoint.id
}
