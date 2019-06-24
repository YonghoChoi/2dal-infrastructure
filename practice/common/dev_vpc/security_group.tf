resource "aws_default_security_group" "dev_default" {
  vpc_id = "${aws_vpc.dev.id}"

  ingress { # 자기 자신의 Security Group의 모든 inboud 트래픽 허용
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress { # 모든 outboud 트래픽 허용
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev-default"
  }
}