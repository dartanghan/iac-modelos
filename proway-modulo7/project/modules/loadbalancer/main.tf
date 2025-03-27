data "aws_ami" "imagem_ec2" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [ "al2023-ami-2023.*-x86_64" ]
    }
}

resource "aws_network_interface" "dart_nginx_ei" {
  subnet_id = aws_subnet.sn_pub01.id
  tags = {
    Name = "dart_nginx_ei"
  }
}

resource "aws_instance" "dart_nginx_ec2" {
  instance_type = "t3.micro"
  ami = data.aws_ami.imagem_ec2.id
  subnet_id = aws_subnet.sn_pub01.id
  vpc_security_group_ids = [ var.dart_nginx_sg_id ]
  
  associate_public_ip_address = true
  tags = {
    Name = "dart-nginx_ec2"
  }
}