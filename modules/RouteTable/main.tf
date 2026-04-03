resource "aws_route_table" "aws_study_routetable" {

  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
}

resource "aws_route_table_association" "publicsubnet1a" { #ルートテーブルとPablicSubnet1aとの紐づけ
  subnet_id      = var.subnet_1a_id
  route_table_id = aws_route_table.aws_study_routetable.id
}

resource "aws_route_table_association" "publicsubnet1c" { #ルートテーブルとPablicSubnet1cとの紐づけ
  subnet_id      = var.subnet_1c_id
  route_table_id = aws_route_table.aws_study_routetable.id
}

