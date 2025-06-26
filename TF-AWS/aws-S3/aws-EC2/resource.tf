resource "aws_instance" "myserver" {
   ami = "ami-0f1dcc636b69a6438"
   instance_type = "t2.micro"
   tags = {
   name = "testing server"
   }
     
   }
   