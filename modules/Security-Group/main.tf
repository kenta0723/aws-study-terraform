

#httpプロバイダを使用して、下記URLから自分のIPアドレスを取得する
data "http" "myip" {
  url = "https://api.ipify.org"
}

locals {

  my_ip = "${data.http.myip.response_body}/32"
}

#====================
# EC2
#====================


resource "aws_security_group" "aws_study_sg" {

  name   = "aws_study_sg"
  vpc_id = var.vpc_id



  tags = {
    Name = "aws_study_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_from_myip" {

  security_group_id = aws_security_group.aws_study_sg.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = local.my_ip
}

resource "aws_vpc_security_group_ingress_rule" "http_from_VPC" {

  security_group_id = aws_security_group.aws_study_sg.id
  # referenced=どのSGからの通信を許可するか
  referenced_security_group_id = aws_security_group.aws_study_ELB_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  description                  = "http from VPC"
}

resource "aws_vpc_security_group_ingress_rule" "https8080port_from_VPC" {

  security_group_id = aws_security_group.aws_study_sg.id
  # referenced=どのSGからの通信を許可するか
  referenced_security_group_id = aws_security_group.aws_study_ELB_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 8080
  to_port                      = 8080
  description                  = "http from VPC"
}

resource "aws_vpc_security_group_egress_rule" "ec2" {
  security_group_id = aws_security_group.aws_study_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#====================
# RDS
#====================

resource "aws_security_group" "aws_study_sg_rds" {

  name   = "aws_study_sg_rds"
  vpc_id = var.vpc_id

  tags = {
    Name = "aws_study_sg_rds"
  }

}

resource "aws_vpc_security_group_ingress_rule" "RDS" {

  security_group_id = aws_security_group.aws_study_sg_rds.id
  ip_protocol       = "tcp"
  from_port         = 3306
  to_port           = 3306
  description       = "http from VPC"
  referenced_security_group_id = aws_security_group.aws_study_sg.id
}

#====================
# ELB
#====================

resource "aws_security_group" "aws_study_ELB_sg" {

  name   = "ELBsecuritygroup"
  vpc_id = var.vpc_id

  tags = {
    Name = "ELB_securitygroup"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ELB" {

  security_group_id = aws_security_group.aws_study_ELB_sg.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0" #cidrは確認しよう

}

resource "aws_vpc_security_group_ingress_rule" "https" {

  security_group_id = aws_security_group.aws_study_ELB_sg.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0" #cidrは確認しよう
}

resource "aws_vpc_security_group_egress_rule" "ELB" {
  security_group_id = aws_security_group.aws_study_ELB_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}