variable "machine" {
  type = object({
    micro = string
    small = string
  })
}

variable "zone" {
  type = object({
    default      = string
    alternative  = string
    alternative1 = string
  })
}

variable "image" {
  type        = string
  description = "OS system image of the VMs"
}

variable "flower" {
  type = object({
    username = string
    password = string
  })
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
}

variable "vpc_network_name" {
  type = string
}

variable "backend_instance_address" {
  type = string
}
