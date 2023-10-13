resource "aws_eip" "ngw" {
  domain           = "vpc"
  associate_with_private_ip = "10.0.0.5"
  depends_on                = [aws_internet_gateway.gw]
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = aws_subnet.public_1a.id

  tags = {
    Name = "bcit-private"
  }
  depends_on = [aws_eip.ngw]
}