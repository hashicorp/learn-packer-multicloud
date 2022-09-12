data "hcp_packer_iteration" "hashicups" {
  bucket_name = var.hcp_bucket_hashicups
  channel     = var.hcp_channel
}

data "hcp_packer_image" "aws_hashicups" {
  bucket_name    = data.hcp_packer_iteration.hashicups.bucket_name
  iteration_id   = data.hcp_packer_iteration.hashicups.ulid
  cloud_provider = "aws"
  region         = "us-west-1"
}

data "hcp_packer_image" "azure_hashicups" {
  bucket_name    = data.hcp_packer_iteration.hashicups.bucket_name
  iteration_id   = data.hcp_packer_iteration.hashicups.ulid
  cloud_provider = "azure"
  region         = "westus3"
}