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

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "common_tags" {
  type = map(string)
  default = {
    "ManagedBy" = "Terraform"
    "Team"      = "DevOps"
  }
}
