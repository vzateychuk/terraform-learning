resource "aws_vpc" "web_dev_vpc" {
  cidr_block = "10.0.0.0/16"
}

data "aws_ami" "aws_t3" {
  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-0c4c4bd6cf0c5fe52"]
  }

  owners = ["137112412989"] # Amazon Linux 2023 AMI
}

resource "aws_instance" "web" {
  ami = data.aws_ami.aws_t3.id
  instance_type = var.instance_type

  tags = {
    Name = "web"
    Env = "dev"
  }
  
}