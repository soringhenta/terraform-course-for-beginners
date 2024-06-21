resource "aws_instance" "tf_example" {
  ami                         = data.aws_ami.ubuntu_lts.id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.tf_ssh.id, aws_security_group.tf_web.id]
  key_name                    = aws_key_pair.tf_keypair.id
  user_data_replace_on_change = true
  user_data                   = <<-EOF
                #!/bin/bash
                sudo apt install -y apache2 mysql-client
                sudo a2enmod ssl
                sudo a2ensite default-ssl.conf
                sudo systemctl reload apache2
                sudo systemctl start apache2
                echo "My IP is $(curl -s ifconfig.me)" |sudo tee /var/www/html/index.html >/dev/null
                EOF
  tags = {
    Name = "TF-Example"
  }
}