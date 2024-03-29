variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The VPC CIDR Block"
}

variable "enabledns_hostnames" {
  type        = bool
  default     = true
  description = "Assign true to enable dns host names else false"
}

variable "common_tags" {
  type = map(string)
  default = {
    "ManagedBy" = "Terraform"
    "Team"      = "DevOps"
  }
}

variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.0.0/18", "10.0.64.0/18", "10.0.128.0/19"]
  description = "Public Subnet CIDRS List"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.160.0/19", "10.0.192.0/19", "10.0.224.0/19"]
  description = "Private Subnet CIDRS List"
}

variable "aws_availabilityzones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "ami_maps" {
  type = map(string)
  default = {
    "Redhat" = "ami-0fe630eb857a6ec83"
    "Ubuntu" = "ami-07d9b9ddc6cd8dd30"
    "Amazon" = "ami-0440d3b780d96b29d"
  }
  description = "AMI Ids With OS Distributions"
}

variable "os_name" {
  type    = string
  default = "Redhat"
}


variable "instance_type" {
  type    = string
  default = "t2.micro"
}
