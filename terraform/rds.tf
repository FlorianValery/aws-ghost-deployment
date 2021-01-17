resource "aws_db_instance" "default" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = var.mysql_engine_version
  instance_class         = var.mysql_instance_class
  name                   = var.mysql_name
  username               = var.mysql_username
  password               = var.mysql_password
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  parameter_group_name   = var.mysql_parameter_group_name
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]
}

resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "main"
  subnet_ids = [module.vpc.database_subnets[0], module.vpc.database_subnets[1]]

  tags = merge(var.tags,
    {
      "Name" = "mysql-subnet-group"
  })
}

resource "aws_security_group" "mysql_sg" {
  name        = "mysql_sg"
  description = "mysql_sg"
  vpc_id      = module.vpc.vpc_id


  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "TCP"
    # Security group that will be used by the ASG, see asg.tf
    security_groups = [aws_security_group.ghost_asg_sg.id]
  }

  egress {
    from_port = 3306
    to_port   = 3306
    protocol  = "TCP"
    # Security group that will be used by the ASG, see asg.tf
    security_groups = [aws_security_group.ghost_asg_sg.id]
  }

  tags = merge(var.tags,
    {
      "Name" = "mysql-subnet-group"
  })
}