# Create VPC
resource "aws_vpc" "my_vpc_testing_01" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "my-vpc-testing-01"
  }
}

# Create Private Subnet
resource "aws_subnet" "private_subnet_01" {
  vpc_id            = aws_vpc.my_vpc_testing_01.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a" # optional but recommended for production
  
  tags = {
    Name = "private-subnet"
  }
}

# Create Public Subnet
resource "aws_subnet" "public_subnet_01" {
  vpc_id            = aws_vpc.my_vpc_testing_01.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1a" # optional
  
  tags = {
    Name = "public-subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc_testing_01.id

  tags = {
    Name = "my-igw"
  }
}

# Create Route Table
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc_testing_01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my-route-table"
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet_01.id
  route_table_id = aws_route_table.my_rt.id
}