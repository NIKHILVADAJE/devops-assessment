variable "vpc_cidr" {}
variable "env" {}
resource "aws_vpc" "main" { cidr_block = var.vpc_cidr; tags = { Name = "${var.env}-vpc" } }
resource "aws_subnet" "public" { vpc_id = aws_vpc.main.id; cidr_block = "10.0.1.0/24" }
resource "aws_subnet" "private" { vpc_id = aws_vpc.main.id; cidr_block = "10.0.2.0/24" }
output "vpc_id" { value = aws_vpc.main.id }
output "public_subnet_id" { value = aws_subnet.public.id }
output "private_subnet_id" { value = aws_subnet.private.id }
