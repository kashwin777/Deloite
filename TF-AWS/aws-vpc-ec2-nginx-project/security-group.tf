resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.my_vpc_testing_01.id

  # Inbound rule - Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule - Allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-sg"
  }
}