# Role for EC2
resource "aws_iam_role" "ec2_role_2" {
  name = "ec2-role-2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

# Policy for EC2
resource "aws_iam_policy" "ec2_policy_2" {
  name        = "ec2-deployment-policy-2"
  description = "Policy for EC2 instance to deploy applications"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::teachua-bucket-new",
          "arn:aws:s3:::teachua-bucket-new/*"
        ]
      },
      {
        Action = [
          "elasticbeanstalk:DescribeEnvironments",
          "elasticbeanstalk:CreateEnvironment",
          "elasticbeanstalk:UpdateEnvironment",
          "elasticbeanstalk:TerminateEnvironment"
        ]
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = "logs:*"
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = "rds-db:connect",
        Effect = "Allow",
        Resource = "arn:aws:rds-db:*:*:dbuser/*/*"
      },
      {
        Action = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBClusters",
          "rds:Connect"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach policy to EC2 role
resource "aws_iam_role_policy_attachment" "new_ec2_policy_attachment" {
  role       = aws_iam_role.ec2_role_2.name
  policy_arn = aws_iam_policy.ec2_policy_2.arn
}

# Instance profile for EC2
resource "aws_iam_instance_profile" "ec2_instance_profile_2" {
  name = "teachua-instance-profile-2"
  role = aws_iam_role.ec2_role_2.name
}

# Role for Beanstalk
resource "aws_iam_role" "beanstalk_role_2" {
  name = "beanstalk-role-2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

# Policy for Beanstalk
resource "aws_iam_policy" "beanstalk_policy_2" {
  name        = "beanstalk-policy-2"
  description = "Policy for Beanstalk"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "elasticbeanstalk:*",
          "logs:*",
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach policy to Beanstalk role
resource "aws_iam_role_policy_attachment" "new_beanstalk_policy_attachment" {
  role       = aws_iam_role.beanstalk_role_2.name
  policy_arn = aws_iam_policy.beanstalk_policy_2.arn
}

resource "aws_iam_instance_profile" "beanstalk_ec2_instance_profile_2" {
  name = "beanstalk-ec2-instance-profile-2"
  role = aws_iam_role.beanstalk_ec2_role_2.name
}

# Role for Beanstalk EC2
resource "aws_iam_role" "beanstalk_ec2_role_2" {
  name = "beanstalk-ec2-role-2"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Policy attachment for Beanstalk EC2 logging
#resource "aws_iam_policy_attachment" "beanstalk_ec2_logging_2" {
#  name       = "beanstalk-ec2-logging-2"
#  roles      = [aws_iam_role.beanstalk_ec2_role_2.name]
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkWebTier"
#}

# Policy attachment for CloudWatch logs
resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.beanstalk_ec2_role_2.name
}



