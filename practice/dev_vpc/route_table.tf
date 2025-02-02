# dev_public
resource "aws_route_table" "dev_public" {
  vpc_id = "${aws_vpc.dev.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dev.id}"
  }

  tags = {
    Name = "dev-public"
  }
}

resource "aws_route_table_association" "dev_public_1" {
  subnet_id      = "${aws_subnet.public_subnet_1.id}"
  route_table_id = "${aws_route_table.dev_public.id}"
}

resource "aws_route_table_association" "dev_public_2" {
  subnet_id      = "${aws_subnet.public_subnet_2.id}"
  route_table_id = "${aws_route_table.dev_public.id}"
}