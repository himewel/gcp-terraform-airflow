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
