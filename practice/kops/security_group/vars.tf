variable "region" {}

variable "vpc" {}

variable "vpn_ip" {
    default = "119.206.206.251/32"
    description = "VPN IP for accessing the EC2 instance"
}