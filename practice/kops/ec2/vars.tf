variable "amazon_linux_ami" {}
variable "ubuntu_ami" {}
variable "region" {}
variable "subnet_1" {}
variable "subnet_2" {}
variable "az_1" {}
variable "az_2" {}

variable "vpc" {
  default = "vpc-75032a12"
}

variable "k8s_cluster_name" {
  default = "irene.k8s.local"
}

variable "k8s_state_store" {
  default = "s3://irene-terraform"
}

variable "zones" {
  default = "ap-southeast-1b"
}
variable "master-zones" {
  default = "ap-southeast-1b"
}

variable "node-count" {
  default = "1"
}
variable "node-size" {
  default = "t2.medium"
}
variable "node-volume-size" {
  default = 20 
}
variable "master-count" {
  default = 3 
}
variable "master-size" {
  default = "t2.medium"
}
variable "master-volume-size" {
  default = 20 
}
variable "topology" {
  default = "private" 
}
variable "api-loadbalancer-type" {
  default = "internal"
}
variable "subnets" {
  default = "subnet-58303211"
}

variable "admin-access" {
  default = "172.31.0.0/16"
}
variable "network-cidr" {
  default = "172.31.0.0/16"
}
variable "utility-subnets" {
  default = "subnet-58303211"
}
variable "image" {
  default = "ami-0dad20bd1b9c8c004"
}
variable "networking" {
  default = "calico"
}
variable "cloud-labels" {
   default = "Owner=yongho1037"
}

variable "ec2_passwd_prameter_name" {
   default = "kops-ubuntu-password"
   description = "Parameter name of AWS Parameter Store"
}