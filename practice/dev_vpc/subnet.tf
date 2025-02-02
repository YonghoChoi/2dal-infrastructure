resource "aws_subnet" "public_subnet_1" {
  vpc_id            = "${aws_vpc.dev.id}"
  availability_zone = "${var.az_1}"
  cidr_block        = "172.16.1.0/24"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = "${aws_vpc.dev.id}"
  availability_zone = "${var.az_2}"
  cidr_block        = "172.16.2.0/24"

  tags = {
    Name = "public-subnet-2"
  }
}