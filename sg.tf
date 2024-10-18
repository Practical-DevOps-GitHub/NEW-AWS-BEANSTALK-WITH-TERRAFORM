resource "aws_security_group" "new_teachua_beanstalk_app_elb_sg" {
  name        = "new-teachua-beanstalk-elb-sg"
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
    Name = "New_Beanstalk_ELB_SG"
  }
}

resource "aws_security_group" "new_teachua_beanstalk_instance" {
  name        = "new-teachua-beanstalk-instance-sg"
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Дозволити доступ до RDS з IP-адреси Beanstalk
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  
  }

  tags = {
    Name = "New_Beanstalk_Instance_SG"
  }
}

resource "aws_security_group" "new_application_database_sg" {
  name        = "new-application-database-sg"
  description = "Security group for database connection"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.new_teachua_beanstalk_instance.id] 
  }


  tags = {
    Name = "New_Application_Database_SG"
  }
}

resource "aws_security_group" "new_teachua_app_rds_sg" {
  name        = "new-teachua-app-rds-sg"
  description = "Security group for RDS"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  
  }

  tags = {
    Name = "New_Teachua_App_RDS_SG"
  }
}

