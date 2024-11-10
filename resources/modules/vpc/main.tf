#-------------
# Create VPC
#-------------

resource "aws_vpc" "dev_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-VPC"
    env : var.environment
  }
}

#--------------------------------------------------
# Create An Internet Gateway And Attach It To VPC
#--------------------------------------------------

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "${var.project_name}-IGW"
    env : var.environment
  }
}

#-------------------------------------------------------------
# Create a Public Subnet In The First Availability Zone (AZ1)
#-------------------------------------------------------------

resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = "Pub Subnet-AZ1"
    env : var.environment
  }
}

#-------------------------------------------------------------
# Create a Public Subnet In The Second Availability Zone (AZ2)
#-------------------------------------------------------------

resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet-AZ2"
    env : var.environment
  }
}

#----------------------------------------
# Create Route Table and Add Public Route
#----------------------------------------

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-RT"
    env : var.environment
  }
}
#-------------------------------------------------------------------------------------------------------
# Associate Public Subnets In First, Second Availabilty Zones (AZ1) With The Public Route Table for AZ1
#-------------------------------------------------------------------------------------------------------

# a) - Associate Public Subnet in az1 with Public Route Table for AZ1
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}

#-------------------------------------------------------------------------------------------------------
# Associate Public Subnets In First, Second Availabilty Zones (AZ1) With The Public Route Table for AZ1
#-------------------------------------------------------------------------------------------------------

# b) - Associate Public Subnet in az2 with Public Route Table for AZ1
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_route_table.id
}


#---------------------------------------------------------------------------
# Allocate Elastic IP Address In The First Availability Zone (EIP in AZ1)
#----------------------------------------------------------------------------

resource "aws_eip" "eip_for_nat_gateway_az1" {
  domain = "vpc"

  tags = {
    Name = "EIP-AZ1"
    env : var.environment
  }
}

#---------------------------------------------------------------------------
# Allocate Elastic IP Address In The First Availability Zone (EIP in AZ2)
#----------------------------------------------------------------------------

resource "aws_eip" "eip_for_nat_gateway_az2" {
  domain = "vpc"

  tags = {
    Name = "EIP-AZ2"
    env : var.environment
  }
}

#-------------------------------------------------------------------------------------
# Create a "NAT Gateway AZ1" With Public Subnet In The First Availability Zone  (AZ1)
#-------------------------------------------------------------------------------------

resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip_for_nat_gateway_az1.id
  subnet_id     = aws_subnet.public_subnet_az1.id
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name = "Nat Gateway AZ1"
    env : var.environment
  }
}

#-------------------------------------------------------------------------------------
# Create a "NAT Gateway AZ2" With Public Subnet In The Second Availability Zone  (AZ2)
#-------------------------------------------------------------------------------------

resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.eip_for_nat_gateway_az2.id
  subnet_id     = aws_subnet.public_subnet_az2.id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = "Nat Gateway AZ2"
    env : var.environment
  }
}


#------------------------------------------------------------------
# Create Private App Subnet In The First Availability Zone (AZ1)
#-------------------------------------------------------------------

resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.private_app_subnet_az1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet-AZ1"
    env : var.environment
  }
}

#-----------------------------------------------------------------
# Create Private App Subnet In The Second Availability Zone (AZ2)
#-----------------------------------------------------------------

resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.private_app_subnet_az2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet-AZ2"
    env : var.environment
  }
}

#----------------------------------------------------------------------
# Create Private Database Subnet In The First Availability Zone (AZ1)
#----------------------------------------------------------------------

resource "aws_subnet" "private_database_subnet_az1" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.private_database_subnet_az1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Database subnet-AZ1"
    env : var.environment
  }
}

#-----------------------------------------------------------------------
# Create Private Database Subnet In The Second Availability Zone (AZ2)
#-----------------------------------------------------------------------

resource "aws_subnet" "private_database_subnet_az2" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.private_database_subnet_az2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Database subnet-AZ2"
    env : var.environment
  }
}

#--------------------------------------------------------------------------
# Create A Private Route Table For The First Availability Zone (AZ1)
#--------------------------------------------------------------------------

resource "aws_route_table" "private_route_table_az1" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az1.id
  }
  tags = {
    Name = "Private RT-AZ1"
    env : var.environment
  }
}

#-----------------------------------------------------------------------
# Create A Private Route Table For The Second Availability Zone (AZ2)
#-----------------------------------------------------------------------

resource "aws_route_table" "private_route_table_az2" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az2.id
  }
  tags = {
    Name = "Private RT-AZ2"
    env : var.environment
  }
}

#-----------------------------------------------------------------------------------------------
# Associate All Private Subnets In The First Availability (AZ1) With Route Table For AZ1
#-----------------------------------------------------------------------------------------------

# a) - Associate private app subnet in the the second availability zon (az1) with Private Route Table For AZ1

resource "aws_route_table_association" "private_app_subnet_az1_route_table_association" {
  subnet_id      = aws_subnet.private_app_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}

# b) - Associate private database subnet in the the second availability zon (az1) with Private Route Table For AZ1

resource "aws_route_table_association" "private_database_subnet_az1_route_table_association" {
  subnet_id      = aws_subnet.private_database_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}


#-----------------------------------------------------------------------------------------------
# Associate All Private Subnets In The Second Availability (AZ2) With Route Table For AZ2
#-----------------------------------------------------------------------------------------------

# a) - Associate "private app subnet in the the second availability zon (az2) with Private Route Table For AZ2

resource "aws_route_table_association" "private_app_subnet_az2_route_table_association" {
  subnet_id      = aws_subnet.private_app_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id
}

# b) - Associate "private database subnet in the the second availability zon (az2) with Private Route Table For AZ2

resource "aws_route_table_association" "private_database_subnet_az2_route_table_association" {
  subnet_id      = aws_subnet.private_database_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id
}




