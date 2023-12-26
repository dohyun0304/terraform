resource "aws_subnet" "rds_subnet_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.rds_subnet_a_cidr
  availability_zone = var.rds_az_a

  tags = {
    Name = "rds-subnet-a"
  }
}

resource "aws_subnet" "rds_subnet_b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.rds_subnet_b_cidr
  availability_zone = var.rds_az_b

  tags = {
    Name = "rds-subnet-b"
  }
}


resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.rds_name}-subnet-group"
  subnet_ids = [aws_subnet.rds_subnet_a.id, aws_subnet.rds_subnet_b.id]
}



resource "aws_db_instance" "rds_instance" {
  identifier             = var.rds_name
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_allocated_storage
  engine                 = var.rds_engine
  engine_version         = var.engine_version
  username               = var.rds_username
  password               = var.rds_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
}

resource "aws_security_group" "rds_sg" {
  name       = "${var.rds_name}-sg"
  vpc_id     = var.vpc_id
  depends_on = [aws_subnet.rds_subnet_a, aws_subnet.rds_subnet_b]
}

resource "aws_security_group_rule" "rds_sg_rules_cidr" {
  for_each = var.rds_sg_rules_cidr

  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr_blocks]
  security_group_id = aws_security_group.rds_sg.id
}