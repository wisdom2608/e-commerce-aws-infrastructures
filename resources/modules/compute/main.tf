#----------------
# Create Key Pair
#----------------

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh-key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "local-file" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.filename
}

#-----------------------------------------------------
# Create A Bastion Host Instances In The Public Subnets
#------------------------------------------------------
resource "aws_instance" "bastion-host" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  subnet_id                   = var.public_subnet_az1_id
  vpc_security_group_ids      = [var.ssh_sg_id]

  tags = {
    Name = "${var.webserver_name}-1"
    env : var.environment
  }
}

#----------------------------------------------------
# Create EC2 Instances In The Private App Subnets AZ1
#----------------------------------------------------
resource "aws_instance" "appserver-1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = false
  subnet_id                   = var.private_app_subnet_az1_id
  vpc_security_group_ids      = [var.app_server_sg_id]
  tags = {
    Name = "${var.appserver_name}-1"
    env : var.environment
  }

}

resource "aws_instance" "appserver-2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = false
  subnet_id                   = var.private_app_subnet_az2_id
  vpc_security_group_ids      = [var.app_server_sg_id]
  tags = {
    Name = "${var.appserver_name}-2"
    env : var.environment
  }
}

