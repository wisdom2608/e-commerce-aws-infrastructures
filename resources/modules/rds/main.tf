# Create a DB Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "subnet-group"
  description = "subnet group for rds"
  subnet_ids  = [var.private_database_subnet_az1_id, var.private_database_subnet_az2_id]

  tags = {
    Name = "${var.project_name}-Subnet-Group"
    env : var.environment
  }
}

# Create the RDS Instance
resource "aws_db_instance" "dev-db" {
  engine                  = var.db_engine
  engine_version          = "8.0.35"
  multi_az                = false
  allocated_storage       = 20
  storage_type            = "gp2"
  instance_class          = var.db_instance_class
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.admin_login_key
  parameter_group_name    = "default.mysql8.0"
  identifier              = var.db_identifier 
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 7
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [var.database_sg_id]
  availability_zone       = var.database_az1

  tags = {
    Name = "${var.project_name}-db"
    env : var.environment
  }
}