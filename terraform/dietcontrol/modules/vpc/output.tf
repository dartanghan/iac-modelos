output "vpc_id" {
    value = aws_vpc.vpc.id
}
output "subnet_pub_a_id" {
    value = aws_subnet.subnet_pub_a.id
}
output "subnet_pub_b_id" {
    value = aws_subnet.subnet_pub_b.id
}
output "subnet_priv_a_id" {
    value = aws_subnet.subnet_priv_a.id
}
output "subnet_priv_b_id" {
    value = aws_subnet.subnet_priv_b.id
}