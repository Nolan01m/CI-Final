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
  key_name      = "My_Key"

  network_interface {
    network_interface_id = aws_network_interface.Splunk_Interface.id
    device_index         = 0
  }
  connection {
    private_key = file(var.private_key)
    user        = var.ansible_user
  }
  tags = {
    Name = "Splunk-${count.index + 1}"
  }
}
resource "aws_instance" "Cartography_Instance" {
  count = var.instance_count

  ami           = "ami-0128839b21d19300e"
  instance_type = var.instance
  key_name      = "My_Key"

  network_interface {
    network_interface_id = aws_network_interface.Cartography_Interface.id
    device_index         = 0
  }
  /*
  provisioner "local-exec" {
    command = <<EOT
      sleep 30;
          >Cartography.ini;
          echo "[Cartography]" | tee -a Cartography.ini;
          echo "${aws_instance.Cartography_Instance.0.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.private_key}" | tee -a Cartography.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
          ansible-playbook -u var.ansible_user --private-key var.private_key -i Cartography.ini ../Playbooks/install_Cartography.yaml
    EOT
  }
*/
  tags = {
    Name = "Cartography-${count.index + 1}"
  }
}

  