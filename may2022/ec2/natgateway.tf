resource "aws_nat_gateway" "demo_nat" {
    subnet_id = aws_subnet.pub_sub_2.id
    allocation_id = aws_eip.nat_eip.id

    tags = {
      Name = "demo-nat"
    }
  
}

resource "aws_eip" "nat_eip" {}

resource "aws_route" "nat_route" {
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.demo_nat.id
}