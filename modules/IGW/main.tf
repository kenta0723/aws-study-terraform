

resource "aws_internet_gateway" "IGW" {

  vpc_id = var.vpc_id #cfnではアタッチメントを別で記載していたがここでVPCを指定して紐づけることでattachmentを省略可能。

  tags = {
    Name = "aws-study-IGW"
  }
}

