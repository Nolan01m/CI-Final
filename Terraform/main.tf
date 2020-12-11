//# Hostnames = learn.nhlabs.org & splunk.nhlabs.org
terraform {
  backend "remote" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
resource "aws_key_pair" "My_Key" {
  key_name   = "My_Key"
  public_key = file(var.public_key)
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
  count = var.instance_count

  ami           = "ami-0b0944867dcc4cf5a"
  instance_type = var.instance
  key_name = "My_Key"

  network_interface {
    network_interface_id = aws_network_interface.Splunk_Interface.id
    device_index         = 0
  }
  tags = {
    Name = "Splunk_Instance"
  }
}
resource "aws_instance" "Cartography_Instance" {
  count = var.instance_count

  ami           = "ami-0128839b21d19300e"
  instance_type = var.instance
  key_name = "My_Key"

  network_interface {
    network_interface_id = aws_network_interface.Cartography_Interface.id
    device_index         = 0
  }
  tags = {
    Name = "Cartography_Instance"
  }
}