data "terraform_remote_state" "sg_data" {
    backend = "local"
    config = {
        path = "${path.module}/../security_group/terraform.tfstate"
    }
}

data "terraform_remote_state" "iam_role_data" {
    backend = "local"
    config = {
        path = "${path.module}/../iam/role/terraform.tfstate"
    }
}

data "aws_ssm_parameter" "ec2-password" {
  name = "${var.ec2_passwd_prameter_name}"
}

resource "aws_instance" "kops" {
  ami                  = "${var.ubuntu_ami}"
  availability_zone    = "${var.az_1}"
  instance_type        = "t2.micro"
  key_name             = "${var.key_pair}"
  iam_instance_profile = "${data.terraform_remote_state.iam_role_data.outputs.kops_iam_instance_profile_name}"
  vpc_security_group_ids = [
    "${data.terraform_remote_state.sg_data.outputs.kops_sg_id}",
  ]

  subnet_id                   = "${var.subnet_1}"
  associate_public_ip_address = true
  user_data = <<EOF
#!/bin/bash
echo "ubuntu:${data.aws_ssm_parameter.ec2-password.name}" | chpasswd
sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
service sshd restart
  EOF

  tags = {
    Name = "kops"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = "${data.aws_ssm_parameter.ec2-password.name}"
    host        = "${self.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y curl awscli",
      "curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '\"' -f 4)/kops-linux-amd64",
      "chmod +x kops",
      "sudo mv kops /usr/local/bin/",
      "kops version",
      "curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl",
      "chmod +x ./kubectl",
      "sudo mv ./kubectl /usr/local/bin/kubectl",
      "kubectl version",
      "cat /dev/zero | ssh-keygen -q -N ''",
      "kops create secret --name ${var.k8s_cluster_name} --state ${var.k8s_state_store} sshpublickey admin -i ~/.ssh/id_rsa.pub",
      "kops delete cluster --name ${var.k8s_cluster_name} --state ${var.k8s_state_store} --yes",
      "kops create cluster --name ${var.k8s_cluster_name} --state ${var.k8s_state_store} --zones=${var.zones} --master-zones=${var.master-zones} --node-count=${var.node-count} --node-size=${var.node-size} --node-volume-size=${var.node-volume-size} --node-security-groups=${data.terraform_remote_state.sg_data.outputs.kops_sg_id} --master-count=${var.master-count} --master-size=${var.master-size} --master-volume-size=${var.master-volume-size} --master-security-groups=${data.terraform_remote_state.sg_data.outputs.kops_sg_id} --topology=${var.topology} --api-loadbalancer-type=${var.api-loadbalancer-type} --subnets=${var.subnets} --admin-access=${var.admin-access} --vpc=${var.vpc} --network-cidr=${var.network-cidr} --utility-subnets=${var.utility-subnets} --image='${var.image}' --networking=${var.networking} --cloud-labels '${var.cloud-labels}' --yes",
    ]
  }

  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      "kops delete cluster --name ${var.k8s_cluster_name} --state ${var.k8s_state_store} --yes",
    ]
  }
}