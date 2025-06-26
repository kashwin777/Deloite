ec2_config = [ {
  ami           = "ami-0e35ddab05955cf57" # ubuntu
  instance_type = "t2.micro"
  }, {
  
      ami = "ami-0e35ddab05955cf57" # amezon linux
      instance_type = "t3.nano"
    
}]

ec2_map = {
  "ubuntu" = {
    ami           = "ami-0e35ddab05955cf57" # ubuntu
  instance_type = "t2.micro"
    
  },
  "amezon-linux" = {
    ami = "ami-0e35ddab05955cf57" # amezon linux
      instance_type = "t2.micro"

  }
}