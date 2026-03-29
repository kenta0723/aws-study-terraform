#==================
#ELB
#==================

resource "aws_lb" "aws_elb" {

  name = "elb"

  ip_address_type = "ipv4"

  subnets = [

    var.subnet_1a_id,
    var.subnet_1c_id

  ]

  security_groups = [var.elb_sg_id]


}
