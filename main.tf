

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.5.0"
    }
  }
}

provider "http" {}

provider "aws" {
  region = "ap-northeast-1"
}

module "VPC" {
  source = "./modules/vpc"
}

module "Subnet" {
  source = "./modules/Subnet"

  vpc_id = module.VPC.vpc_id
}

module "IGW" {
  source = "./modules/IGW"

  vpc_id = module.VPC.vpc_id
}

module "RouteTable" {
  source = "./modules/RouteTable"

  vpc_id = module.VPC.vpc_id

  igw_id = module.IGW.igw_id

  subnet_1a_id = module.Subnet.public_1a_id

  subnet_1c_id = module.Subnet.public_1c_id
}

module "Security_Group" {
  source = "./modules/Security-Group"

  vpc_id = module.VPC.vpc_id
}

module "EC2" {
  source = "./modules/EC2"

  subnet_1a_id = module.Subnet.public_1a_id

  ec2_sg_id = module.Security_Group.ec2_sg_id
}

module "RDS" {
  source = "./modules/RDS"

  rds_sg_id = module.Security_Group.rds_sg_id

  db_masteryourname = var.db_masteryourname
  db_masterpassword = var.db_masterpassword

  db_subnet_group_id = module.Subnet.db_subnet_group_id



}

module "ALB_target_group" {
  source = "./modules/ALB_target_group"

  vpc_id = module.VPC.vpc_id
  ec2_id = module.EC2.ec2_id
}

module "ALB" {
  source = "./modules/ALB"

  subnet_1a_id = module.Subnet.public_1a_id

  subnet_1c_id = module.Subnet.public_1c_id

  elb_sg_id = module.Security_Group.elb_sg_id

}

module "ListenerRule" {
  source = "./modules/ListenerRule"

  aws_elb_arn = module.ALB.aws_elb_arn

  alb_tg_arn = module.ALB_target_group.alb_tg_arn
}

module "CloudWatch" {
  source = "./modules/CloudWatch"

  aws_study_ec2_id = module.EC2.ec2_id

  aws_sns_topic_arn = module.AWSSNSTopic.aws_sns_topic_arn
}

module "WAF" {
  source = "./modules/WAF"

  aws_elb_arn = module.ALB.aws_elb_arn

  cloudwatchlogs_arn = module.CloudWatch.cloudwatchlogs_arn
}

module "AWSSNSTopic" {
  source = "./modules/AWSSNSTopic"

  my_email_address = var.my_email_address
}