variable "profile" {
  default = "terraform_iam_user"
}

variable "region" {
  default = "us-east-1"
}

variable "instance" {
  default = "t2.micro"
}

variable "instance_count" {
  default = "1"
}

variable "public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "private_key" {
  default = "~/.ssh/id_rsa"
}

variable "ansible_user" {
  default = "ec2-user"
}

variable "ansible_play" {
  default = "null"
}

variable "hec_token" {
  default = "dbf77230-1434-4ce4-9696-4beb68e9aaa1"
  
}
variable "SplunkPassword" {
  default = "SPLUNK-i-089e40aa39d440950"
  
}