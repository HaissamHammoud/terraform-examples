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
module "lambda" {
  source = "./lambda"
  count = 0
}

module "ecs-example" {
  source = "./ecs"
  count = 0
}

module "ec2-machine" {
  source = "./ec2"
  count = 0
}

module "gke" {
  source = "./kubernetes/gke"
  count = 0

  project_id="operating-ethos-383111"
  region="us-central1"
  node_disk_size=20
  gke_num_nodes=1
  namespaces= ["application", "test", "monitoring"]
}