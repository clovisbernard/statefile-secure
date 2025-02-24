variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "The Amazon Machine Image ID for the instance"
  type        = string
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "key_name" {
  description = "The key pair name for SSH access"
  type        = string
  default     = "key-2024"
}
