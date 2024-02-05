# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

data "hcp_packer_version" "hashicups" {
  bucket_name  = var.hcp_bucket_hashicups
  channel_name = var.hcp_channel
}

data "hcp_packer_artifact" "aws_hashicups" {
  bucket_name         = data.hcp_packer_version.hashicups.bucket_name
  version_fingerprint = data.hcp_packer_version.hashicups.fingerprint
  platform            = "aws"
  region              = var.aws_region
}

data "hcp_packer_artifact" "azure_hashicups" {
  bucket_name         = data.hcp_packer_version.hashicups.bucket_name
  version_fingerprint = data.hcp_packer_version.hashicups.fingerprint
  platform            = "azure"
  region              = var.azure_region
}