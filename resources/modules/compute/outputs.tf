output "appserver-1_id" {
  value = aws_instance.appserver-1.id
}

output "appserver-2_id" {
  value = aws_instance.appserver-2.id
}


output "bastion-host_ip" {
  value = aws_instance.bastion-host.public_ip
}

output "appserver-1_ip" {
  value = aws_instance.appserver-1.private_ip
}

output "appserver-2_ip" {
  value = aws_instance.appserver-2.private_ip
}

