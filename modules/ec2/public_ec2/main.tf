resource "aws_instance" "public_instance" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  tags = {
    Name        = "${var.name}-${count.index}"
    Environment = var.environment
  }
  depends_on = [aws_security_group_rule.public_instance_sg_rule]
}

resource "aws_eip_association" "eip_assoc" {
  count         = length(var.public_instance_eip_ids)
  instance_id   = aws_instance.public_instance[count.index].id
  allocation_id = element(var.public_instance_eip_ids, count.index)
}

resource "aws_security_group" "security_group" {
  name        = "${var.name}-sg"
  description = "Security group for ${var.name}"
  vpc_id      = var.vpc_id
}


resource "aws_security_group_rule" "public_instance_sg_rule" {
  for_each = { for idx, rule in var.public_instance_sg_rule["instance1"] : idx => rule }

  type      = each.value.type
  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol

  security_group_id = aws_security_group.security_group.id

  cidr_blocks = each.value.cidr_blocks
}

