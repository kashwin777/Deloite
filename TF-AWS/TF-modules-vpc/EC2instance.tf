module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name = "test-instance"
  ami  = "ami-062f0cc54dbfd8ef1"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.my-vpc-testing.default_security_group_id]
  subnet_id              = module.my-vpc-testing.public_subnets[0]
  tags = {
    Name = "module-project"
    Environment = "dev"
  }
}
