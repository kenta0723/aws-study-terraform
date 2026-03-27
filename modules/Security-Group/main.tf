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

# EC2用SG（SSH: 自分IP / HTTP: ELBから）
resource "aws_security_group" "ec2_sg" {

  name   = "aws_study_sg"
  vpc_id = var.vpc_id



  tags = {
    Name = "aws_study_sg"
  }
}

#====================
# RDS
#====================

# RDS用SG（EC2からのMySQL接続のみ許可）
resource "aws_security_group" "rds_sg" {

  name   = "aws_study_sg_rds"
  vpc_id = var.vpc_id

  tags = {
    Name = "aws_study_sg_rds"
  }

}

#====================
# ELB
#====================

resource "aws_security_group" "elb_sg" {

  name   = "elbsecuritygroup"
  vpc_id = var.vpc_id

  tags = {
    Name = "elb_securitygroup"
  }
}

#====================
# ingress_rure
#====================

resource "aws_vpc_security_group_ingress_rule" "ssh_from_myip" {

  security_group_id = aws_security_group.ec2_sg.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = local.my_ip
}

resource "aws_vpc_security_group_ingress_rule" "http_from_elb" {

  security_group_id = aws_security_group.ec2_sg.id
  # referenced=どのSGからの通信を許可するか(ELBのセキュリティグループからのHTTP通信を許可)
  referenced_security_group_id = aws_security_group.elb_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  description                  = "http from elb sg"
}

resource "aws_vpc_security_group_ingress_rule" "http8080port_from_elb" {

  security_group_id = aws_security_group.ec2_sg.id
  # referenced=どのSGからの通信を許可するか(ELBのセキュリティグループからのHTTP通信を許可)
  referenced_security_group_id = aws_security_group.elb_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 8080
  to_port                      = 8080
  description                  = "http 8080 from elb sg"
}

resource "aws_vpc_security_group_ingress_rule" "rds" {

  security_group_id            = aws_security_group.rds_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306
  description                  = "mysql from EC2 sg"
  referenced_security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_vpc_security_group_ingress_rule" "elb" {

  security_group_id = aws_security_group.elb_sg.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

#====================
# egress_rure
#====================

resource "aws_vpc_security_group_egress_rule" "ec2" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "elb" {
  security_group_id = aws_security_group.elb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}