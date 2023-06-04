variable "PUB_SUBNET_1" {
  type = string
}

variable "SG_SSH" {
  type = string
}

variable "AMI_OWNERS" {
  type    = list(string)
  default = ["099720109477"]
}