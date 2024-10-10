resource "aws_security_group" "teachua-beanstalk-app-elb-sg" {
  name        = "teachua-beanstalk-elb-sg"
  description = "Security group for beanstalk load balancer"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Beanstalk_ELB_SG"
  }
}


resource "aws_security_group" "teachua-beanstalk-Instance" {
  name        = "teachua-beanstalk-instance-sg"
  description = "Security group for beanstalk instance"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  #security_groups = [aws_security_group.teachua-beanstalk-elb-sg.id]  
  cidr_blocks     = ["0.0.0.0/0"]
}

  tags = {
    Name = "Beanstalk_instance_SG"
  }
}


resource "aws_security_group" "teachua_app_rds_sg" {
  name        = "teachua_application_database_sg"
  description = "Security group for database connection"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    # security_groups = [aws_security_group.teachua-beanstalk-Instance.id]
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS_instance_SG"
  }
}