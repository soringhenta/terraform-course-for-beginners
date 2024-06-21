# Create SSH-KEY
resource "tls_private_key" "ed25519-key" {
  algorithm = "ED25519"
}

# Create AWS Key pair
resource "aws_key_pair" "tf_keypair" {
  key_name   = "TF Keypair"
  public_key = tls_private_key.ed25519-key.public_key_openssh
}

# Copy the pvt key locally
resource "local_sensitive_file" "tf_pvt_key" {
  content              = tls_private_key.ed25519-key.private_key_openssh
  filename             = pathexpand("~/.ssh/${var.ssh_key_name}")
  file_permission      = 600
  directory_permission = 700
}

resource "local_sensitive_file" "tf_pub_key" {
  content              = tls_private_key.ed25519-key.public_key_pem
  filename             = pathexpand("~/.ssh/${var.ssh_key_name}.pub")
  file_permission      = 600
  directory_permission = 700
}