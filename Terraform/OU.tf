
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