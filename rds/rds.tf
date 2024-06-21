resource "aws_db_instance" "tf_db" {
  identifier             = var.db_instance_name
  allocated_storage      = 10
  engine                 = "mariadb"
  instance_class         = var.db_instance_class
  db_name                = "mydb"
  username               = var.db_username
  password               = random_password.password.result
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.tf_mysql.id]
}