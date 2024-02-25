module "vpc" {
  source               = "./vpc"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  cidr_public_subnet   = var.cidr_public_subnet
  eu_availability_zone = var.eu_availability_zone
  cidr_private_subnet  = var.cidr_private_subnet
}


module "security_group" {
  source                     = "./sg"
  ec2_sg_name                = "SG for EC2 to enable SSH(22) and HTTP(80)"
  vpc_id                     = module.vpc.dev_proj_vpc_id
  public_subnet_cidr_block   = tolist(module.vpc.public_subnet_cidr_block)
  ec2_sg_name_for_python_api = "SG for EC2 for enabling port 5000"
}

module "ec2" {
  source                   = "./ec2"
  ami_id                   = var.ec2_ami_id
  instance_type            = "t2.micro"
  tag_name                 = "Ubuntu Linux EC2"
  public_key               = var.public_key
  subnet_id                = tolist(module.vpc.dev_proj_public_subnets)[0]
  sg_enable_ssh_https      = module.security_group.sg_ec2_sg_ssh_http_id
  ec2_sg_name_for_python_api     = module.security_group.sg_ec2_for_python_api
  enable_public_ip_address = true
  user_data_install_apache = templatefile("./template/ec2_install_apache.sh", {})
}

module "lb_target_group" {
  source                   = "./lb-tg"
  lb_target_group_name     = "dev-proj-lb-target-group"
  lb_target_group_port     = 5000
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.vpc.dev_proj_vpc_id
  ec2_instance_id          = module.ec2.dev_proj_ec2_instance_id
}

module "alb" {
  source                    = "./lb"
  lb_name                   = "dev-proj-alb"
  is_external               = false
  lb_type                   = "application"
  sg_enable_ssh_https       = module.security_group.sg_ec2_sg_ssh_http_id
  subnet_ids                = tolist(module.vpc.dev_proj_public_subnets)
  tag_name                  = "dev-proj-alb"
  lb_target_group_arn       = module.lb_target_group.dev_proj_lb_target_group_arn
  ec2_instance_id           = module.ec2.dev_proj_ec2_instance_id
  lb_listner_port           = 5000
  lb_listner_protocol       = "HTTP"
  lb_listner_default_action = "forward"
  lb_https_listner_port     = 443
  lb_https_listner_protocol = "HTTPS"
  lb_target_group_attachment_port = 5000
}


module "rds_db_instance" {
  source               = "./rds"
  db_subnet_group_name = "dev_proj_rds_subnet_group"
  subnet_groups        = tolist(module.vpc.dev_proj_public_subnets)
  rds_mysql_sg_id      = module.security_group.rds_mysql_sg_id
  mysql_db_identifier  = "mydb"
  mysql_username       = "dbuser"
  mysql_password       = "dbpassword"
  mysql_dbname         = "devprojdb"
}


