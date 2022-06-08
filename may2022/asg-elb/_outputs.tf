output "alb_endpoint" {
    value = aws_lb.my_alb.dns_name
  
}

output "clb_endpoint" {
    value =  join ("", ["http://", aws_elb.my_clb.dns_name])
}