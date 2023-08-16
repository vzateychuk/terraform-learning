resource "aws_subnet" "web_dev_1a" {
  vpc_id = aws_vpc.web_dev_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "web-dev-1a"
  }
}