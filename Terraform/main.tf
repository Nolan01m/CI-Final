//# Hostname = learn.nhlabs.org & splunk.nhlabs.org
terraform {
  backend "remote" {}
  //# allow emote execute tf code from local cli
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
//# Create a VPC
resource "aws_vpc" "nhlabs" {
  cidr_block = "10.0.0.0/28"
  tags = {
    Name = "nhlabs"
  }
}
//##Instances##\\
//# Create an EC2 instance
resource "aws_instance" "Splunk_Instance" {

  ami           = "ami-0b0944867dcc4cf5a"
  instance_type = "t2.micro"
  key_name = "NolanLT"

  network_interface {
    network_interface_id = aws_network_interface.Splunk_Interface.id
    device_index         = 0

  }
  tags = {
    Name = "Splunk_Instance"
  }
}

resource "aws_key_pair" "NolanLT" {
  key_name   = "NolanLT"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6rxjSnsygKdSqaoawLSc9FA2gjWU8mS60hY7WzpU5fxah7Wohyi9dWGJTq2JiZ12HwAZTmP2FleQXXZPJgc4dPbpJXRp3nehgqAcDdu09WRG94WpP2n+pZdflfnZ86NiAAlF5nlmaFXZ0hsNNpx74WQ4CpRhXMehrtHW9/oDpKjOr6n7TAfDj7IKMxtJvgGptj3skVXHMW3QSVhQcO+VUKLSog91rK+U5rU3NV3MEnk51EGHxDwNqNmF1S0GCcN2p2P3XQ6hNsUcV+wHQqMGAnU60bljQtyY8ruoLhnt5s69hAmZFfbSrJaEsuOgGZ4EiYEy23tMM9h43x795BXPx+r/3ts8l3zx34eGgEwsQlEsIklfuAfUR/BiEy6PJLLBDuoTxjfDGMiS0H9En98pv7+by3kEGg98glZ0Wivc0VzeUmSRLYRFaJUe+cq3otPFYaOFmBUnglBovESM78Im9inqg9XkE6ZKlMXQVDjkOUqlxPMt6oFtqqwbmq4jBdjCiFUlAyqyhsXqXz/+oM1FZdUAJi/7Yt7Kc6203HylzMusQlw/em9Og3dzqyPfqduIcnFWn69SfGGY+csXTJnCy8SaVSMnkSJ3vBSr30uH05bryMvvWaEzEZoBU+fvwS9g2ssQQyXghZMSQzDWgdDMOdsxdNqLnwjyIsNEXqHD55Q== nolan.heimlich@gmail.com"
}



/*
resource "aws_organizations_account" "account" {
  name  = "nhlabs"
  email = "nolan@nhlabs.org"
}

resource "aws_organizations_organizational_unit" "nhlabs" {
  name      = "students"
  parent_id = aws_organizations_organization.org.roots[0].id
}
*/

/*
resource "aws_organizations_account" "account" {
  name  = "nhlabs"
  email = "nolan@nhlabs.org"
}

resource "aws_organizations_organizational_unit" "nhlabs" {
  name      = "students"
  parent_id = aws_organizations_organization.org.roots[0].id
}
*/
/*
# Ansible requires Python to be installed on the remote machine as well as the local machine.
  provisioner "remote-exec" {
    inline = ["sudo apt-get -qq install python -y"]
  }
  
  connection {
    private_key = "${file(var.private_key)}"
    user        = "ubuntu"
  }
  */