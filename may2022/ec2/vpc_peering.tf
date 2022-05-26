resource "aws_vpc_peering_connection" "gold_to_silver" {
  peer_vpc_id = aws_vpc.silver_vpc.id
  vpc_id      = aws_vpc.golden_vpc.id
  auto_accept = true

  tags = {
    Name = "gold-silver-peering"
  }
}

