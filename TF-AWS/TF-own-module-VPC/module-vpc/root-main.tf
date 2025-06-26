module "vpn" {
  source = "./module/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/24"
    name       = "my-test-vpc"
  }
}
