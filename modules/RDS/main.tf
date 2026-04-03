resource "aws_db_instance" "rds" {

  allocated_storage = 20

  db_name = "awsstudy"

  engine         = "mysql"
  engine_version = "8.0.43"
  instance_class = "db.t4g.micro"

  #認証情報
  password = var.db_masterpassword
  username = var.db_masteryourname

  #サブネット・セキュリティグループ紐づけ
  db_subnet_group_name   = var.db_subnet_group_id
  vpc_security_group_ids = [var.rds_sg_id]

  auto_minor_version_upgrade = "true"
  storage_type               = "gp2"
  backup_retention_period    = 1
  parameter_group_name       = "default.mysql8.0"
  skip_final_snapshot        = "true"
}