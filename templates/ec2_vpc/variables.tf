variable "aws_profile" {
  type    = "string"
  default = "fission"
}
variable "aws_region" {
  type    = "string"
  default = "us-east-2"
}
variable "creds_loc" {
  type    = "string"
  default = "~/.aws/credentials"
}

variable "ubuntu_ami" {
  type    = "string"
  default = "ami-0fc20dd1da406780b"
}
variable "account_id" {
  type    = "string"
  default = "834406757853"

}
