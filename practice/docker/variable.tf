variable "amazon_linux_ami" {
  # Amazon Linux 2 AMI (HVM), SSD Volume Type
  default = "ami-0602ae7e6b9191aea"
}

variable "ubuntu_ami" {
  # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type
  default = "ami-0dad20bd1b9c8c004"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "vpc" {
  default = "vpc-75032a12"
}

variable "subnet_1" {
  default = "subnet-d28a98b5"
}

variable "subnet_2" {
  default = "subnet-322fe66b"
}

variable "az_1" {
  default = "ap-southeast-1a"
}

variable "az_2" {
  default = "ap-southeast-1c"
}

variable "key_pair" {
  default = "yongho1037"
}

variable "private_key_path" {
  default = "E:/private/aws_key-pair/yongho1037-southeast-1.pem"
}