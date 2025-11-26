terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "terraform-20251125135314834800000001"
    # Key MUST be unique
    key = "sorin/s3/terraform.tfstate"
    region = "eu-central-1"
    # Replace this with your DynamoDB table name if terraform < v1.11!
    # dynamodb_table = "helloworld-locks-sorin"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "helloworld" {
  instance_type = "t3.micro"
  ami = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [aws_security_group.infocomingfw-ssh.id , aws_security_group.infocomingfw-http.id , aws_security_group.infocomingfw-https.id]
  key_name               = aws_key_pair.tfcourse.id
  tags = {
    Name = "HelloWorld-Sorin"
  }
}

resource "aws_security_group" "infocomingfw-ssh" {
  name = "terraform-example-instance-sorin-ssh"
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "infocomingfw-http" {
  name = "terraform-example-instance-sorin-http"
  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "infocomingfw-https" {
  name = "terraform-example-instance-sorin-https"
  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_key_pair" "tfcourse" {
  key_name   = "ssh-sorin"
  public_key = var.ssh_key
}

data "aws_ami" "ubuntu" {

    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/*/ubuntu-*-24.04-amd64-server-*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}



