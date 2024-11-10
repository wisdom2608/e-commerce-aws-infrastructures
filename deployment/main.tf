#--------------
#Create VPC
#--------------
module "vpc" {
  source                           = "../resources/modules/vpc"
  region                           = var.region
  project_name                     = var.project_name
  vpc_cidr                         = var.vpc_cidr
  az1                              = var.az1
  az2                              = var.az2
  public_subnet_az1_cidr           = var.public_subnet_az1_cidr
  public_subnet_az2_cidr           = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr      = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr      = var.private_app_subnet_az2_cidr
  private_database_subnet_az1_cidr = var.private_database_subnet_az1_cidr
  private_database_subnet_az2_cidr = var.private_database_subnet_az2_cidr
  environment                      = var.environment
}

#-----------------------
# Create Security Group
#-----------------------
module "security_groups" {
  source       = "../resources/modules/security-group"
  vpc_id       = module.vpc.vpc_id
  myip_address = var.myip_address
  environment = module.vpc.environment
}

#---------------------
# Create EC2 Instances
#---------------------
module "compute" {
  source                    = "../resources/modules/compute"
  ami                       = var.ami
  instance_type             = var.instance_type
  key_name                  = var.key_name
  filename                  = var.filename
  public_subnet_az1_id      = module.vpc.public_subnet_az1_id
  private_app_subnet_az1_id = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id = module.vpc.private_app_subnet_az2_id
  ssh_sg_id                 = module.security_groups.ssh_sg_id
  app_server_sg_id          = module.security_groups.app_server_sg_id
  appserver_name            = var.appserver_name
  webserver_name            = var.webserver_name
  environment               = module.vpc.environment
}

#---------------------------------
# Create Application Load Balancer
#---------------------------------
module "alb" {
  source               = "../resources/modules/alb"
  project_name         = module.vpc.project_name 
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
  appserver-1_id       = module.compute.appserver-1_id
  appserver-2_id       = module.compute.appserver-2_id
  alb_sg_id            = module.security_groups.alb_sg_id
  vpc_id               = module.vpc.vpc_id
  environment          = module.vpc.environment
}

#-----------
# Create RDS
#-----------
module "rds" {
  source                         = "../resources/modules/rds"
  project_name                   = module.vpc.project_name
  private_database_subnet_az1_id = module.vpc.private_database_subnet_az1_id
  private_database_subnet_az2_id = module.vpc.private_database_subnet_az2_id
  database_sg_id                 = module.security_groups.database_sg_id
  database_az1                   = var.database_az1
  db_engine                      = var.db_engine
  db_instance_class              = var.db_instance_class
  db_name                        = var.db_name
  db_identifier                  = var.db_identifier
  db_username                    = var.db_username
  admin_login_key                = var.admin_login_key
  environment                    = module.vpc.environment
}

#-----------------------
# Create VPC Endpoints
#-----------------------

module "vpc_endpoint" {
  source                = "../resources/modules/vpc-endpoints"
  vpc_id                = module.vpc.vpc_id
  project_name          = module.vpc.project_name
  public-route_table_id = module.vpc.public-route_table_id
  environment           = module.vpc.environment
}


# output "output" {
#  value = module.alb.dns_name
#  value = module.compute.webserver-1.public_ip
#  value = module.compute.webserver-2.public_ip
#  value = module.compute.appserver-1.private_ip
#  value = module.compute.appserver-2.private_ip
#  value = module.rds.aws_db_instance.dev-db.endpoint
# }