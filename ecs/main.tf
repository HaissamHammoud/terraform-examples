module "network" {
    source = "./network"
}

module "services" {
    source = "./services"
}

module "ec2" {
    source = "./ec2"
}