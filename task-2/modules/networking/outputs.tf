output "vpc_id" {
  value = data.aws_vpc.default.id
}

output "security_group_id" {
  value = aws_security_group.node_sg.id
}

output "public_subnet_id" {
  value = data.aws_subnets.default.ids[0]
}
