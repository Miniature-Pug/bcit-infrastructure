resource "aws_db_subnet_group" "mysql" {
  name       = "bcit-rds-subnet-group"
  subnet_ids = [data.aws_subnet.private-1a.id, data.aws_subnet.private-1b.id]
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 5
  db_name              = "mysqldb"
  engine               = "mysql"
  engine_version       = "8.0.34"
  availability_zone = "us-east-1a"
  backup_retention_period = 0
  delete_automated_backups = true
  db_subnet_group_name = aws_db_subnet_group.mysql.id
  instance_class       = "db.t3.micro"
  identifier = "bcit-rds"
  username             = "root"
  manage_master_user_password = true
  max_allocated_storage = 0
  monitoring_interval = 0
  network_type = "IPV4"
  performance_insights_enabled = false
  port = 3306
  publicly_accessible = false
  skip_final_snapshot  = true
  storage_type = "gp2"
  vpc_security_group_ids = [aws_security_group.rds.id]
  tags = {
    Name = "bcit"
  }
}

