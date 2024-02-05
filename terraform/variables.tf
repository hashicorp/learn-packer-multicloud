# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "aws_region" {
  description = "The AWS region Terraform should deploy your instance to"
  default     = "us-west-1"
}

variable "azure_region" {
  description = "The Azure region Terraform should deploy your instance to"
  default     = "westus3"
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}
variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default     = "10.1.0.0/24"
}

variable "environment_tag" {
  description = "Environment tag"
  default     = "Learn"
}

variable "hcp_bucket_hashicups" {
  description = "HCP Packer bucket name for hashicups image"
  default     = "learn-packer-multicloud-hashicups"
}

variable "hcp_channel" {
  description = "HCP Packer channel name"
  default     = "production"
}

variable "azure_resource_group" {
  description = "Azure Resource Group name where Terraform will create infrastructure"
}
