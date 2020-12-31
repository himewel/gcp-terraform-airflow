output "vpc_network" {
  value = google_compute_network.vpc_network.name

  depends_on = [
    google_compute_firewall.internal,
  ]
}

output "internal_firewall_ip_range" {
  value = google_compute_firewall.internal.source_ranges
}

output "internal_firewall_rules" {
  value = google_compute_firewall.internal.allow
}
