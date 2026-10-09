output "server_1_public_ip" {
  value = aws_instance.server_1.public_ip
}

output "server_2_public_ip" {
  value = aws_instance.server_2.public_ip
}

output "server_1_instance_id" {
  value = aws_instance.server_1.id
}

output "server_2_instance_id" {
  value = aws_instance.server_2.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}