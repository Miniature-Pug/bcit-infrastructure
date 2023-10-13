resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "bcit-public"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "bcit-private"
  }
}

resource "aws_route" "r" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public-route-1a" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public_1a.id
}

resource "aws_route_table_association" "public-route-1b" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public_1b.id
}

resource "aws_route" "nat-ngw-route" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.ngw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private-route-1a" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private_1a.id
}

resource "aws_route_table_association" "private-route-1b" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private_1b.id
}
