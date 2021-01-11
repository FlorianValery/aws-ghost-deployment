data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"] # Retrieves the latest approved image  
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "ghost_lc" {
  name_prefix          = "ghost-lc"
  image_id             = data.aws_ami.ubuntu.image_id
  security_groups      = [aws_security_group.ghost_asg_sg.id]
  instance_type        = var.ec2_instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # path to the user data file
  user_data = templatefile("${path.module}/user_data/ghost_init.sh",
    {
      # This is pulled from the rds resource created in rds.tf
      "endpoint" = aws_db_instance.default.address,
      "database" = aws_db_instance.default.name,
      "username" = aws_db_instance.default.username,
      # !!! Remember to find a secure way to retrieve your password
      "password"  = var.mysql_password,
      "admin_url" = var.website_admin_url,
      "url"       = var.website_url
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ghost_asg" {
  name                 = "ghost-asg"
  launch_configuration = aws_launch_configuration.ghost_lc.name
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  vpc_zone_identifier  = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]

  # Associate the ASG with the Application Load Balancer target group.
  target_group_arns = [aws_lb_target_group.ghost_lb_tg.arn]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "ghost_asg_sg" {
  name        = "ghost-asg-sg"
  description = "Security group for the ghost instances"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Ingress rule for http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # Security group that will be used by the ALB, see alb.tf
    security_groups = [aws_security_group.ghost_lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags,
    {
      "Name" : "ghost-asg-sg"
  })
}
