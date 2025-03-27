output "vpc_id" {
    value = aws_vpc.vpc.id
}
output "sn_priv01" {
    value = aws_subnet.sn_priv01.id
}
output "sn_priv02" {
    value = aws_subnet.sn_priv02.id
}
output "sn_pub01" {
    value = aws_subnet.sn_pub01.id
}
output "sn_pub02" {
    value = aws_subnet.sn_pub02.id
}
output "dart_nginx_sg_id" {
    value = aws_security_group.dart_nginx_sg.id
}