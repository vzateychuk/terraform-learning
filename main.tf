data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631"] # Bitnami
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type

  vpc_security_group_ids = [ module.web_sg.security_group_id ]

  tags = {
    Name = "web"
    Env  = "dev"
  }

}

data "aws_vpc" "default" {
  default = true
}

module "web_sg" {
  name        = "web_server_sg"
  description = "Allow http/ssh in. Allow everything out"
  vpc_id      = data.aws_vpc.default.id

  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  ingress_rules       = ["http-80-tcp", "http-8080-tcp", "ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]

}
