//# Hostnames = learn.nhlabs.org & splunk.nhlabs.org
#Test
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
/*
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.Splunk_EBS.id
  instance_id = aws_instance.Splunk_Instance.0.id
}

resource "aws_ebs_volume" "Splunk_EBS" {
  availability_zone = "us-east-1a"
  size              = 20
  snapshot_id       = "n/a"

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [arn]

  }

  tags = {
    Name = "Splunk_EBS"
  }
}
*/
resource "aws_instance" "Splunk_Instance" {
  count = var.instance_count


  ami           = "ami-0c003fe096c2c12e1"
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
  tags = {
    Name = "Cartography-${count.index + 1}"
  }
}
//##Backups##\\
resource "aws_backup_vault" "backup_splunk" {
  name = "backup_splunk"
}
resource "aws_backup_plan" "backup_splunk" {
  name = "backup_splunk"

  rule {
    rule_name         = "backup_splunk"
    target_vault_name = "backup_splunk"
    schedule          = "cron(0 12 * * ? *)"
  }
}
resource "aws_iam_role" "backup" {
  name               = "backup"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}
resource "aws_backup_selection" "backups" {
  iam_role_arn = aws_iam_role.backup.arn
  name         = "backup_selection"
  plan_id      = aws_backup_plan.backup_splunk.id

  resources = [
    aws_instance.Splunk_Instance.0.arn
  ]
}
resource "aws_backup_region_settings" "backups" {
  resource_type_opt_in_preference = {
    "DynamoDB"        = false
    "Aurora"          = false
    "EBS"             = true
    "EC2"             = true
    "EFS"             = false
    "FSx"             = false
    "RDS"             = false
    "Storage Gateway" = false
  }
}
//##CloudTrail##\\
