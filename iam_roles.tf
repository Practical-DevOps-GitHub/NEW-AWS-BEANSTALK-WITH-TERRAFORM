resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"

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

resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2-deployment-policy"
  description = "Policy for EC2 instance to deploy applications"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::teachua-bucket-new",
          "arn:aws:s3:::teachua-bucket-new/*"
        ]
      },
      {
        Action = "elasticbeanstalk:*"
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = "logs:*"
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "teachua-instance-profile"
  role = aws_iam_role.ec2_role.name
}
