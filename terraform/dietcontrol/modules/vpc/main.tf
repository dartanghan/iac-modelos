resource "aws_vpc" "vpc" {
    cidr_block = "${var.vpc_cidr_block}"
    tags = {
        Unity = "${var.project_name}-vpc"
        Name = "${var.project_name}-vpc"
    }
}

resource "aws_eip" "eip_nat" {
    vpc = true
}

#######
# PUBLIC SUBNETS
#######

resource "aws_subnet" "subnet_pub_a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 3)
    availability_zone = "${var.project_region}a"
    tags = {
        Unity = "${var.project_name}-vpc"
        Name = "${var.project_name}-subnet_pub_a"
    }
}
resource "aws_subnet" "subnet_pub_b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 4)
    availability_zone = "${var.project_region}b"
    tags = {
        Unity = "${var.project_name}-vpc"
        Name = "${var.project_name}-subnet_pub_b"
    }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Unity = "${var.project_name}-vpc"
        Name = "${var.project_name}-igw"
    }
}
resource "aws_route_table" "route_pub" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Unity = "${var.project_name}-vpc"
        Name = "${var.project_name}-route_pub"
    }
}
resource "aws_route_table_association" "route_pub_a" {
    subnet_id = aws_subnet.subnet_pub_a.id
    route_table_id = aws_route_table.route_pub.id
}
resource "aws_route_table_association" "route_pub_b" {
    subnet_id = aws_subnet.subnet_pub_b.id
    route_table_id = aws_route_table.route_pub.id
}
resource "aws_nat_gateway" "gw_nat" {
    allocation_id = aws_eip.eip_nat.id
    subnet_id = aws_subnet.subnet_pub_a.id
    tags = {
        Unity = "${var.project_name}-vpc"
        Name = "${var.project_name}-gw_nat"
    }
}

#######
#  / PUBLIC SUBNETS
#######

#######
# PRIV SUBNETS
#######

resource "aws_subnet" "subnet_priv_a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 1)
    availability_zone = "${var.project_region}a"
    tags = {
        Unity = "${var.project_name}-vpc"
        Name = "${var.project_name}-subnet_priv_a"
    }
}
resource "aws_subnet" "subnet_priv_b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 2)
    availability_zone = "${var.project_region}b"
    tags = {
        Unity = "${var.project_name}-vpc"
        Name = "${var.project_name}-subnet_priv_b"
    }
}
resource "aws_route_table" "route_priv" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gw_nat.id
    }
    tags = {
        Unity = "${var.project_name}-vpc"
        Name = "${var.project_name}-route_priv"
    }
}

resource "aws_route_table_association" "route_priv_a" {
    subnet_id = aws_subnet.subnet_priv_a.id
    route_table_id = aws_route_table.route_priv.id
}
resource "aws_route_table_association" "route_priv_b" {
    subnet_id = aws_subnet.subnet_priv_b.id
    route_table_id = aws_route_table.route_priv.id
}