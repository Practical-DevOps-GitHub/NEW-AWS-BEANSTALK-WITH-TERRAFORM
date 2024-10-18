resource "aws_db_subnet_group" "new_teachua_app_db_subnet_group" {
  name       = "new-teachua-sg"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_db_parameter_group" "teachua_param_group_2" {
  name   = "teachua-param-group-2"
  family = "mariadb10.5"  

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "collation_server"
    value = "utf8_bin"
  }
}

resource "aws_db_instance" "new_teachua_rds" {
  allocated_storage      = 20
  storage_type          = "gp2"
  engine                = "mariadb"
  engine_version        = "10.5"
  instance_class        = "db.t3.micro"
  identifier            = "new-teachua-db"
  db_name               = "teachua"
  username              = "user"
  password              = "password"
  # parameter_group_name = "default.mariadb10.5"
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.new_teachua_app_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.new_teachua_app_rds_sg.id]
  parameter_group_name   = aws_db_parameter_group.teachua_param_group_2.name
}
