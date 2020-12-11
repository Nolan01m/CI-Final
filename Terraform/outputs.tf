output "url-Splunk" {
  value = "http://${aws_instance.Splunk_Instance.0.public_ip}:8000"
}
output "url-cartography" {
  value = "http://${aws_instance.Cartography_Instance.0.public_ip}"
}