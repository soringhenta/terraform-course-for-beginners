# Exercise:

1) Create an EC2 instance (You can see other examples). The image must be taken from a data_source.
2) Execute every time you start an EC2 instance the following data:
   1) install `apache2` and `mysql-client`
   2) enable `ssl` apache module (man `a2enmode`)
   3) enable site `default-ssl.conf` (man `a2ensite`)
   4) Override the content of `/var/www/html/index.html` with the string `"My Public IP is ...."` (`curl -s ifconfig.me` returns the public IP)
   
3) Create a RDS instance (See Resource: aws_db_instance). To stay in the free-tier, the instance type should be `db.t3.micro` and the engine `mariadb`
4) Generate a random password and use it in RDS (See `random_password` function)
5) Generate a new ssh key pair. Save the pvt and pub keys in your local `~/.ssh` directory and upload the public in EC2. (See `tls_private_key` (Resource) and `local_sensitive_file` (Resource) or `local_file` (Resource))
6) Create 2 Security groups:
   1) one for SSH (public accessible)
   2) one for the RDS instance (Mysql port accessible ONLY from the EC2 instance private IP)
7) Test the ssh connection and mysql from the client


# Assmptions:

- Try to make the code reusable (use the variables!)
- Use the default VPC
- Define the default values in a tfvars file
- At least one of the variables **MUST** have a validation rule set
- Don't put everything in a single tf file!
- As output I would see:
  - the EC2 public and private IPs
  - the RDS instance IP (not the public)
  - the RDS random password
  - the public ssh key
  - the private ssh key (sensitive)

