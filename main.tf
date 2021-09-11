/*
    Variables
*/

variable "aws_access_key"  {}
variable "aws_secret_key"  {}
variable "aws_region"      {}

/*
    keys
*/
provider "aws" {
  region  = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

/*
    Modules
*/
module "lamda" {
  source = "./lambda"
  count = 1
}