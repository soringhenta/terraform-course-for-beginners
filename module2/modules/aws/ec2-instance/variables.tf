variable "ec2-ami" {
	description = "EC2 AMI ID"
	type = string
    default = "ami-023adaba598e661ac"
}

variable "ec2-instance-type" {
    description = "EC2 Instance type"
    type = string
    default = "t2.micro"
}

variable "ec2-count" {
    description = "Number of EC2 instances"
    type = number
    default = 2
}

variable "ec2-tag" {
    description = "EC2 instance tag"
    type = list(string)
    default = ["tag1", "tag2"]
}

variable "ssh_port" {
	description = "SSH Port"
	type = number
	default = 22
}

variable "ssh_key" {
	description = "SSH key"
	type = string
	default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDGCXao5ftkZiH8JMi9BkTbddBWGG0BFFPUvsvazgku/V1Xlk75RXLRiZYRuuNcit8Vgq2CKTHwEICIw42VctU6gU0RewRS18I/rfGda7cvZsqwMzm13lXswsGRLB0C0eEUFa5M4dCYtQgwb9G61rzDnP4tt2W7elSH644wbCTk2rLZcXjYiw0V8kRsBF4cFJCaqxtkTR5HcOpLfLbBuQD26zrFzTI36Xup8rapBQniAH1I2XxP7pt2sWlX4qDBFjVp6RJ/CbZBIvkEpYe2gTGTpNXvCaAfD9Gi/WWxscR6QikOODPRfRY8fZUfNx29l5EtQeIE373G4BN4LVPwiWOd1Hb9CuuDbjQ1CvUUmmr2DfoIbYvWweuzym/X8MLzt00bjgj62XxAs231jq7fjXAA+1EqjES1D0Dn3XiY9nW/CaK0ilNcSM5M2fFM0+MYCFILZ3ysW02UgvN705sruJIj5y6zIIWHZj28MAQaZceZXtcGKH7vD6pUaYzs5OJewE= nirvana@graylith"
}
