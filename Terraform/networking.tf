resource "aws_internet_gateway" "Gateway" {
  vpc_id = aws_vpc.nhlabs.id
}
resource "aws_route_table" "Routing" {
  vpc_id = aws_vpc.nhlabs.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Gateway.id
  }
}
resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.nhlabs.id
  cidr_block        = "10.0.0.0/28"
  availability_zone = "us-east-1a"
}
resource "aws_route_table_association" "Routing" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.Routing.id
}
//# Interfaces
resource "aws_network_interface" "Splunk_Interface" {
  subnet_id       = aws_subnet.subnet.id
  private_ips     = ["10.0.0.5"]
  security_groups = [aws_security_group.SG1.id, aws_security_group.SG2.id]
}
resource "aws_network_interface" "Cartography_Interface" {
  subnet_id       = aws_subnet.subnet.id
  private_ips     = ["10.0.0.4"]
  security_groups = [aws_security_group.SG1.id]
}
//#External IPs
resource "aws_eip" "External_IP" {
  instance                  = aws_instance.Splunk_Instance.0.id
  vpc                       = true
  associate_with_private_ip = "10.0.0.5"
  depends_on                = [aws_internet_gateway.Gateway]
}
resource "aws_eip" "External_IP2" {
  instance                  = aws_instance.Cartography_Instance.0.id
  vpc                       = true
  associate_with_private_ip = "10.0.0.4"
  depends_on                = [aws_internet_gateway.Gateway]
}
//# Creating a Security Group
resource "aws_security_group" "SG1" {
  name   = "Splunk Web"
  vpc_id = aws_vpc.nhlabs.id

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
}
resource "aws_security_group" "SG2" {
  name   = "Allow SSH"
  vpc_id = aws_vpc.nhlabs.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
}
