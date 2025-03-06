variable "instance_type" {
  default = "t2.micro"
}

variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "eu-north-1"
}

