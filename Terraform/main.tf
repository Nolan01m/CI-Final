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

  network_interface {
    network_interface_id = aws_network_interface.Splunk_Interface.id
    device_index         = 0

  }
  tags = {
    Name = "Splunk_Instance"
  }
}
resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
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