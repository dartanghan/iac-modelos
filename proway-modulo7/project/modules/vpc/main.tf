resource "aws_vpc" "dart_vpc" {
  cidr_block = "172.200.0.0/16"
  tags = {
    Name = "dart-vpc"
  }
}

resource "aws_subnet" "sn_priv01" {
  vpc_id = aws_vpc.dart_vpc.id
  cidr_block = "172.200.1.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "dart-sn_priv01"
  }
}
resource "aws_subnet" "sn_priv02" {
  vpc_id = aws_vpc.dart_vpc.id
  cidr_block = "172.200.2.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "dart-sn_priv02"
  }
}
resource "aws_subnet" "sn_pub01" {
  vpc_id = aws_vpc.dart_vpc.id
  cidr_block = "172.200.3.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "dart-sn_pub01"
  }
}
resource "aws_subnet" "sn_pub02" {
  vpc_id = aws_vpc.dart_vpc.id
  cidr_block = "172.200.4.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "dart-sn_pub02"
  }
}


