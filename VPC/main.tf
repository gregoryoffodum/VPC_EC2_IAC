resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enabledns_hostnames
  tags = merge(var.common_tags,
    {
      "Name" = "Demo-VPC"
    }
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.common_tags, {
    "Name" = "Demo-VPC-IGW"
    }
  )
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = element(var.aws_availabilityzones, count.index)
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  map_public_ip_on_launch = true
  tags = merge(var.common_tags, {
    "Name" = "Demo-VPC-PublicSubnet - ${count.index + 1}"
  })
}


resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.aws_availabilityzones, count.index)
  tags = merge(var.common_tags, {
    "Name" = "Demo-VPC-PrivateSubnet - ${count.index + 1}"
  })
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.common_tags,
    {
      "Name" = "Demo-VPC-PublicRT"
    }
  )

}

resource "aws_route_table_association" "publicrtassociation" {
  count          = length(var.public_subnet_cidrs)
  route_table_id = aws_route_table.publicrt.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}

resource "aws_eip" "eips" {
  count  = length(var.public_subnet_cidrs)
  domain = "vpc"
  tags = merge(var.common_tags,
    {
      "Name" = "ElasticIP-NAT- ${count.index + 1}"
    }
  )
}

resource "aws_nat_gateway" "natgateways" {
  count         = length(var.public_subnet_cidrs)
  allocation_id = element(aws_eip.eips[*].id, count.index)
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)
  tags = merge(var.common_tags,
    {
      "Name" = "Demo-VPC-Nat-${count.index + 1}"
    }
  )

  depends_on = [aws_internet_gateway.main]
}


resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.main.id
  count  = length(var.private_subnet_cidrs)
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.natgateways[*].id, count.index)
  }
  tags = merge(var.common_tags, {
    "Name" = "Demo-VPC-PrivateRoute-${count.index + 1}"
    }
  )
}

resource "aws_route_table_association" "privatertassociation" {
  count          = length(var.private_subnet_cidrs)
  route_table_id = element(aws_route_table.privateroute[*].id, count.index)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
}
