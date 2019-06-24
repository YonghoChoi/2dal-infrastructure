variable "amazon_linux" {
  # Amazon Linux 2 AMI (HVM), SSD Volume Type
  default = "ami-0602ae7e6b9191aea"
}

variable "sample_region" {
  default = "ap-southeast-1"
}

variable "az_1" {
  default = "ap-southeast-1a"
}

variable "az_2" {
  default = "ap-southeast-1c"
}

variable "dev_keyname" {
  default = "yongho1037"
}