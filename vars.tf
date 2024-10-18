variable "REGION" {
  type    = string
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "PUB_KEY" {
  default = "/home/codespace/.ssh/eb_key.pub"
}

variable "PRIV_KEY" {
  default = "/home/codespace/.ssh/eb_key"
}

variable "VPC_NAME" {
  default = "new-teachua-vpc"
}

variable "VPC_CIDR" {
  default = "10.0.0.0/16"
}

variable "PUB_SUB_CIDR" {
  default = "10.0.1.0/24"
}

variable "PRIV_SUB1_CIDR" {
  default = "10.0.2.0/24"
}


variable "PUB_SUB1_CIDR" {
  default = "10.0.1.0/24"
}

variable "PRIV_SUB2_CIDR" {
  default = "10.0.3.0/24"
}

variable "PUB_SUB2_CIDR" {
  default = "10.0.4.0/24"
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile name"
  default     = "new-teachua-instance-profile"
}
