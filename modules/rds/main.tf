variable "vpc_id" {}
variable "private_subnet_id" {}
variable "instance_class" {}
variable "backup_retention_period" {}
variable "deletion_protection" {}
variable "env" {}
resource "aws_security_group" "rds_sg" { name = "${var.env}-rds-sg"; vpc_id = var.vpc_id }
resource "aws_db_instance" "db" {
  allocated_storage       = 20
  engine                  = "postgres"
  instance_class          = var.instance_class
  db_name                 = "mydb"
  username                = "dbadmin"
  password                = "SuperSecretPassword123"
  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = true
}
