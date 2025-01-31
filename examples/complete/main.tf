provider "aws" {
  alias  = "accepter"
  region = var.region
}

provider "aws" {
  alias  = "requester"
  region = var.region
}

module "vpc_peering_cross_account" {
  source = "../../"
  providers = {
    aws.accepter  = aws.accepter
    aws.requester = aws.requester
  }

  requester_vpc_id                          = var.requester_vpc_id
  requester_allow_remote_vpc_dns_resolution = var.requester_allow_remote_vpc_dns_resolution

  accepter_enabled                         = var.accepter_enabled
  accepter_vpc_id                          = var.accepter_vpc_id
  accepter_allow_remote_vpc_dns_resolution = var.accepter_allow_remote_vpc_dns_resolution

  context = module.this.context
}
