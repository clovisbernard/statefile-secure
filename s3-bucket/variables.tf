variable "aws_region_main" {
  type = string
  default = "us-east-1"
}

variable "aws_region_backup" {
  type = string
  default = "us-east-2"
}

variable "env_type" {
  type        = string
  default = "prod"
}

variable "project_name" {
  type        = string
  default = "server"
}
