# -------------------------------------------------------
# Create a Security Group for Application Load Balancer              
# ------------------------------------------------------
# terraform aws create security group

resource "aws_security_group" "alb_sg" {
  name        = "Application Load Balancer Security Group"
  description = "Allow HTTP and HTTPS traffic on port 80/443"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Alb-SG"
    env : var.environment
  }
}

#---------------------------------------------------------------------------------------------
# Create a Security Group for the Bastion Host (Instances in the Public Subnets) aka Jump Box
#---------------------------------------------------------------------------------------------

resource "aws_security_group" "ssh_sg" {
  name        = "SSH Access"
  description = "Enable SSH Access on port 22"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.myip_address}"] # For best practice, the cidr block (source) for ssh traffic is supposed to be from "My IP" address.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSH-SG"
    env : var.environment
  }
  depends_on = [aws_security_group.alb_sg]
}

#-----------------------------------------------------------------------------------
# Create App Server Security Group (Security group to Access Private Subnets ) 
# ------------------------------------------------------------------------------------                            

resource "aws_security_group" "app_server_sg" {
  name        = "App Server Security Group"
  description = "Enable HTTP/HTTPS Access on port 80/443 via Alb-SG, and SSH on port 22 via SSH-SG"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP Access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb_sg.id}"]
  }

  ingress {
    description     = "HTTPS Access"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb_sg.id}"]
  }

  ingress {
    description     = "SSH Access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ssh_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "App Server-SG"
    env : var.environment
  }
  depends_on = [aws_security_group.alb_sg]
}

#----------------------------------
# Create a database Security Group 
#----------------------------------

resource "aws_security_group" "database_sg" {
  name        = "Database Security Group"
  description = "Enable MYSQL/Aurora on port 3306"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow MYSQL Traffic"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.app_server_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Database-SG"
    env : var.environment

  }
  depends_on = [aws_security_group.app_server_sg]
}


# NB: