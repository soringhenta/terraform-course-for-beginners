resource "tls_private_key" "mynewkey" {
    algorithm = "RSA"
}

resource "local_sensitive_file" "pvtkey" {
  filename = "/home/student/.ssh/id_rsa"
  file_permission = 0600
  content = tls_private_key.mynewkey.private_key_openssh
}

resource "aws_key_pair" "sshkey" {
    public_key = tls_private_key.mynewkey.public_key_openssh
    key_name = "vincenzo-newkey"
}