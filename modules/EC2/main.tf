


resource "aws_instance" "aws_study_ec2" {

  ami             = "ami-0599b6e53ca798bb2"
  instance_type   = "t3.micro"
  key_name        = "aws-study-key"
  subnet_id       = var.subnet_1a_id
  security_groups = [var.aws_study_sg_id]
}
