module "vpc" {
  source = "github.com/yonghochoi/2dal-infrastructure/terraform/modules/cheap_vpc"

  name = "dev"  # VPC 이름
  cidr = "172.16.0.0/16"  # VPC에서 사용할 IP 범위 (CIDR)

  azs              = ["ap-southeast-1a", "ap-southeast-1c"]
  public_subnets   = ["172.16.1.0/24", "172.16.2.0/24"]
  private_subnets  = ["172.16.101.0/24", "172.16.102.0/24"]
  database_subnets = ["172.16.201.0/24", "172.16.202.0/24"]

  bastion_ami                 = "${data.aws_ami.amazon_linux_nat.id}"
  bastion_availability_zone   = "${module.vpc.azs[0]}"
  bastion_subnet_id           = "${module.vpc.public_subnets_ids[0]}"
  bastion_ingress_cidr_blocks = ["0.0.0.0/0"]
  bastion_keypair_name        = "yongho1037-kops"
  bastion_instance_profile    = "kops"

  tags = {
    "TerraformManaged"  = "true"
  }
}
