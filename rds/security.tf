# Security group for SSH port
resource "aws_security_group" "tf_ssh" {
  name = "ssh"
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for WEB ports
resource "aws_security_group" "tf_web" {
  name = "web"
  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for RDS Instance
resource "aws_security_group" "tf_mysql" {
  name = "mysql"
  ingress {
    from_port   = var.mysql_port
    to_port     = var.mysql_port
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.tf_example.private_ip}/32"]
    #cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create the random password
resource "random_password" "password" {
  length  = 16
  special = true
}
