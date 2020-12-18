output "url-Splunk" {
  value = "http://${aws_instance.Splunk_Instance.0.public_ip}:8000"
}
output "Splunk-Creds" {
  value = "User:admin  Password: SPLUNK-${aws_instance.Splunk_Instance.0.id}"
}
output "url-cartography" {
  value = aws_instance.Cartography_Instance.0.public_ip
}
#Dyanmic Inventory
resource "local_file" "inventory" {
  filename = "inventory.ini"
  content  = <<EOF
    [Splunk] 
    ${aws_instance.Splunk_Instance.0.public_ip}

    [Others]
    ${aws_instance.Cartography_Instance.0.public_ip}

    EOF
}
#dynamic Ansible Play
output "Ansible_Run" {
  value = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -u ${var.ansible_user} --private-key ${var.private_key} -i inventory.ini ../Playbooks/Main.yaml"
}
  