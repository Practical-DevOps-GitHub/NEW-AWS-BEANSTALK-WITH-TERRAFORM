module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name           = var.VPC_NAME
  cidr           = var.VPC_CIDR
  azs            = [var.ZONE1, var.ZONE2] 
  public_subnets = [var.PUB_SUB1_CIDR, var.PUB_SUB2_CIDR]    
  private_subnets = [var.PRIV_SUB1_CIDR, var.PRIV_SUB2_CIDR] 

  tags = {
    terraform  = "true"
    environment = "testing"
  }

  vpc_tags = {
    Name = var.VPC_NAME
  }
}
