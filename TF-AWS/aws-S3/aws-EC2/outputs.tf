output "aws_instance_public_ip" {
    description = "The public ip adress of EC2 instance"
    value = aws_instance.myserver.public_ip
  
}