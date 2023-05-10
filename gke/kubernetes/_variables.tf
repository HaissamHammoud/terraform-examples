#####################
#gke configurations
#####################
variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}

variable "node_disk_size" {
  default     = 10
  description = "disk size"
}

#####################
#network configuration
#####################
variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

#####################
#namespaces
#####################
#TODO: RECIEVE A OBJECT instead wit namespace configurations details like resources and labels
variable "namespaces" {
  type = list(string) 
  description= "Recieve the defaul namespaces to be created with the cluster"
  dafeult = []
}