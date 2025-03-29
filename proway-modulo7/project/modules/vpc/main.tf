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


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dart_vpc.id
  tags = {
    Name = "dart-igw" 
  }
}

resource "aws_route_table" "route_pub" {
  vpc_id = aws_vpc.dart_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "dart-routetable"
  }
}

resource "aws_route_table_association" "pub01assoc" {
  subnet_id = aws_subnet.sn_pub01.id
  route_table_id = aws_route_table.route_pub.id
}
resource "aws_route_table_association" "pub02assoc" {
  subnet_id = aws_subnet.sn_pub02.id
  route_table_id = aws_route_table.route_pub.id
}

