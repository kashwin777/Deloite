# EC2 for Nginx setup
resource "aws_instance" "nginxserver" {
  ami                         = "ami-0f1dcc636b69a6438"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_01.id
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]  # <-- Use [square brackets] for list
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install nginx -y
              sudo systemctl start nginx
              
            EOF

  tags = {
    Name = "Nginxserver"    # <-- "Name" key must be capital N for AWS EC2 console
  }
}