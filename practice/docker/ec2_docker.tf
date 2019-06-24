resource "aws_security_group" "ec2_docker" {
  name        = "ec2_docker"
  description = "docker on ec2"

  vpc_id = "${var.vpc}"

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
    Name = "ec2_docker"
  }
}

resource "aws_eip" "ec2_docker" {
  instance = "${aws_instance.ec2_docker.id}"
  vpc      = true
}

resource "aws_instance" "ec2_docker" {
  ami               = "${var.ubuntu_ami}"
  availability_zone = "${var.az_1}"
  instance_type     = "t2.micro"
  key_name          = "${var.key_pair}"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("${var.private_key_path}")}"
    host = "${self.public_ip}"
  }

  provisioner "file" {
    source = "dockerfiles"
    destination = "/home/ubuntu/dockerfiles"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo apt-key fingerprint 0EBFCD88",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
      "sudo docker build -t test-nginx ~/dockerfiles",
      "sudo docker run -d -p 80:80 test-nginx",
      "curl localhost",
      "ls -l ~/",
    ]
  }

  vpc_security_group_ids = [
    "${aws_security_group.ec2_docker.id}",
  ]

  subnet_id                   = "${var.subnet_1}"
  associate_public_ip_address = true

  tags = {
    Name = "ec2_docker"
  }
}