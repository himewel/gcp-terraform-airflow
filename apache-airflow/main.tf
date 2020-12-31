module "network" {
  source = "./network"

  vpc_network_name            = var.vpc_network_name
  internal_firewall_ip_ranges = var.internal_firewall_ip_ranges
}

module "backend" {
  source = "./backend"

  machine          = var.machine
  zone             = var.zone
  image            = var.image
  vpc_network_name = module.network.vpc_network
  webserver        = var.webserver
}

module "frontend" {
  source = "./frontend"

  machine                  = var.machine
  zone                     = var.zone
  image                    = var.image
  vpc_network_name         = module.network.vpc_network
  backend_instance_address = module.backend.backend_instance_address
  webserver                = var.webserver
  flower                   = var.flower
}

module "workers" {
  source = "./workers"

  machine                  = var.machine
  zone                     = var.zone.alternative
  image                    = var.image
  vpc_network_name         = module.network.vpc_network
  backend_instance_address = module.backend.backend_instance_address
  instance_name            = "worker-instance-${count.index}"
  count                    = var.number_of_workers
}

module "proxy" {
  source = "./proxy"

  machine                   = var.machine
  zone                      = var.zone
  image                     = var.image
  frontend_instance_address = module.frontend.frontend_instance_address
  vpc_network_name          = module.network.vpc_network
}
