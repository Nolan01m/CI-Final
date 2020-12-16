variable "pubkey" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6rxjSnsygKdSqaoawLSc9FA2gjWU8mS60hY7WzpU5fxah7Wohyi9dWGJTq2JiZ12HwAZTmP2FleQXXZPJgc4dPbpJXRp3nehgqAcDdu09WRG94WpP2n+pZdflfnZ86NiAAlF5nlmaFXZ0hsNNpx74WQ4CpRhXMehrtHW9/oDpKjOr6n7TAfDj7IKMxtJvgGptj3skVXHMW3QSVhQcO+VUKLSog91rK+U5rU3NV3MEnk51EGHxDwNqNmF1S0GCcN2p2P3XQ6hNsUcV+wHQqMGAnU60bljQtyY8ruoLhnt5s69hAmZFfbSrJaEsuOgGZ4EiYEy23tMM9h43x795BXPx+r/3ts8l3zx34eGgEwsQlEsIklfuAfUR/BiEy6PJLLBDuoTxjfDGMiS0H9En98pv7+by3kEGg98glZ0Wivc0VzeUmSRLYRFaJUe+cq3otPFYaOFmBUnglBovESM78Im9inqg9XkE6ZKlMXQVDjkOUqlxPMt6oFtqqwbmq4jBdjCiFUlAyqyhsXqXz/+oM1FZdUAJi/7Yt7Kc6203HylzMusQlw/em9Og3dzqyPfqduIcnFWn69SfGGY+csXTJnCy8SaVSMnkSJ3vBSr30uH05bryMvvWaEzEZoBU+fvwS9g2ssQQyXghZMSQzDWgdDMOdsxdNqLnwjyIsNEXqHD55Q== nolan.heimlich@gmail.com"
}

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