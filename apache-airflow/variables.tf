variable "machine" {
  type = object({
    micro = string
    small = string
  })
  default = {
    micro = "e2-micro"
    small = "e2-small"
  }
}

variable "zone" {
  type = object({
    default      = string
    alternative  = string
    alternative1 = string
  })
  default = {
    default      = "us-central1-a"
    alternative  = "us-east1-b"
    alternative1 = "us-east4-a"
  }
}

variable "image" {
  type        = string
  description = "OS system image of the VMs"
  default     = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
}

variable "webserver" {
  type = object({
    firstname = string
    lastname  = string
    username  = string
    password  = string
    email     = string
    role      = string
  })
  default = {
    username  = "admin"
    password  = "admin"
    firstname = "Welbert"
    lastname  = "Castro"
    email     = "welberthime@hotmail.com"
    role      = "Admin"
  }
}

variable "flower" {
  type = object({
    username = string
    password = string
  })
  default = {
    username = "admin"
    password = "admin"
  }
}

variable "vpc_network_name" {
  type    = string
  default = "terraform-network"
}

variable "internal_firewall_ip_ranges" {
  type = list(string)
  default = [
    "10.128.0.0/20",
    "10.142.0.0/20",
    "10.150.0.0/20",
    "10.138.0.0/20"
  ]
}

variable "credentials_filepath" {
  type        = string
  description = "Filepath to the credentials json"
}

variable "project_id" {
  type        = string
  description = "Id of the GCP project"
}

variable "project_zone" {
  type        = string
  description = "Default zone to create the instances"
}

variable "number_of_workers" {
  type    = number
  default = 4
}
