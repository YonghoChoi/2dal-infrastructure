resource "aws_security_group" "kops" {
  name        = "kops"
  description = "docker based kops server"

  vpc_id = "${var.vpc}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kops"
  }
}

resource "aws_security_group_rule" "kops_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = ["119.206.206.251/32"]
  security_group_id = "${aws_security_group.kops.id}"

  lifecycle { create_before_destroy = true }
}
