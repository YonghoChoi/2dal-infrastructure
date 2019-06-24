resource "aws_security_group" "sample_ec2" {
  name        = "sample_ec2"
  description = "open ssh port for sample_ec2"

  vpc_id = "${aws_vpc.dev.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sample_ec2"
  }
}

resource "aws_eip" "sample_ec2" {
  instance = "${aws_instance.sample_ec2.id}"
  vpc      = true
}

resource "aws_instance" "sample_ec2" {
  ami               = "${var.amazon_linux}"
  availability_zone = "${var.az_1}"
  instance_type     = "t2.nano"
  key_name          = "${var.dev_keyname}"

  vpc_security_group_ids = [
    "${aws_security_group.sample_ec2.id}",
    "${aws_default_security_group.dev_default.id}",
  ]

  subnet_id                   = "${aws_subnet.public_subnet_1.id}"
  associate_public_ip_address = true

  tags = {
    Name = "sample_ec2"
  }
}