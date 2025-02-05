output "alb_dns-name" {
  value = module.alb.alb_dns
}

output "rds_end_point" {

  value = module.rds.rds_end_point
}

output "appserver-1-instance-id" {
  value = module.compute.appserver-1_id
}

output "appserver-2-instance-id" {
  value = module.compute.appserver-2_id
}


output "bastion-host-public-ip" {
  value = module.compute.bastion-host_ip
}

output "appserver-1-private-ip" {
  value = module.compute.appserver-1_ip
}

output "appserver-2-private-ip" {
  value = module.compute.appserver-2_ip
}


