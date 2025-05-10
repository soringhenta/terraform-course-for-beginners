resource "tls_private_key" "newkey" {
  algorithm = "ECDSA"
}

resource "local_file" "newsshkey" {
  content = tls_private_key.newkey.public_key_openssh
  filename = pathexpand("~/.ssh/newkey.pub")
}

output "ssh_key" {
  value = local_file.newsshkey.content
}