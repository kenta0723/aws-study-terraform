
#==================
#ELB
#==================

resource "aws_lb" "aws_ELB" {

  name = "aws-study-elb"

  ip_address_type = "ipv4"

  subnets = [

    var.subnet_1a_id,
    var.subnet_1c_id

  ]

  security_groups = [var.ELB_sg_id]


}
