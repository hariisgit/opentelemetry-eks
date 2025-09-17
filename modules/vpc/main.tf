resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.eks_cluster_name}-vpc"
  }
}

############## Public Subnets ##############

resource "aws_subnet" "public-subnet" {
  count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.eks_vpc.id
  map_public_ip_on_launch = true
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name = "${var.eks_cluster_name}-public-subnet-${count.index + 1}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.eks_cluster_name}-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.eks_vpc.id
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }
}

resource "aws_route_table_association" "rt_association_public" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}


############## Private Subnets ##############

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.eks_cluster_name}-private-subnet-${count.index + 1}"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "eks_nat_gw" {
  count     = length(var.private_subnet_cidrs)
  subnet_id = aws_subnet.private_subnet[count.index].id

  tags = {
    Name = "${var.eks_cluster_name}-nat-gw-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.eks-igw]
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eks_nat_gw.id
  }
}

resource "aws_route_table_association" "rt_association_private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}