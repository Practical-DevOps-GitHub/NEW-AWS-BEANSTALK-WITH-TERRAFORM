resource "aws_elastic_beanstalk_environment" "new_teachua_beanstalk_env" {
  name                = "new-teachua-env"
  application         = aws_elastic_beanstalk_application.new_teachua_app.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.3.2 running Corretto 17"
  tier                = "WebServer"
  cname_prefix        = "new-teachua-app"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.vpc.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "true"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
   value     = join(",", [module.vpc.public_subnets[0], module.vpc.public_subnets[1]])
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", [module.vpc.public_subnets[0], module.vpc.public_subnets[1]])
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.ec2_instance_profile_2.name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.medium"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeType"
    value     = "gp2"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeSize"
    value     = "10"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.teachua_app_key_2.key_name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.new_teachua_beanstalk_instance.id
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = aws_security_group.new_teachua_beanstalk_app_elb_sg.id
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = "Any 3"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "2"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = "/"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "AllAtOnce"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_ec2_instance_profile_2.name
  }

  #setting {
  #  namespace = "aws:elasticbeanstalk:cloudwatch:logs"
  #  option_name = "StreamLogs"
   # value = "true"
  #}

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_REGION"
    value     = var.REGION
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "LOG_LEVEL"
    value     = "info" 
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATASOURCE_URL"
    value     = "jdbc:mariadb://${aws_db_instance.new_teachua_rds.endpoint}/new-teachua"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATASOURCE_USER"
    value     = "user"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATASOURCE_PASSWORD"
    value     = "password"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "JDBC_DRIVER"
    value     = "org.mariadb.jdbc.Driver"
  }       

  depends_on = [
    aws_security_group.new_teachua_beanstalk_app_elb_sg, 
    aws_security_group.new_teachua_beanstalk_instance, 
    aws_security_group.new_teachua_app_rds_sg
  ]
}
