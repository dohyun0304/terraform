resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = false

  tags = {
    Name = "${each.key}-private-subnet"
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.vpc_name}-public-${each.key}"
    Type = "public"
  }
}

resource "aws_subnet" "node_subnet" {
  for_each = var.node_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = {
    Name = "eks-node-${each.key}"
  }
}
resource "aws_eip" "nat_eip" {
  count = var.enable_nat_gateway ? length(var.private_subnets) : 0
}

resource "aws_nat_gateway" "nat_gw" {
  count         = var.enable_nat_gateway ? length(var.private_subnets) : 0
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = tolist(values(aws_subnet.public)[*].id)[count.index]
}

resource "aws_eip" "public_instance_eip" {
  count = length(var.public_subnets)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public_rt" {
  for_each = var.public_subnets

  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = lookup(var.public_route_cidrs, each.key, [])
    content {
      cidr_block = route.value
      gateway_id = aws_internet_gateway.igw.id
    }
  }
}

resource "aws_route_table_association" "public_subnets_rt_association" {
  for_each       = { for s in keys(var.public_subnets) : s => s }
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = lookup(aws_route_table.public_rt, each.key).id
}

resource "aws_route_table" "node_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = var.node_route_cidrs
    nat_gateway_id = aws_nat_gateway.nat_gw[0].id
  }
}


resource "aws_route_table_association" "node_rt_association" {
  for_each       = aws_subnet.node_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.node_rt.id
}