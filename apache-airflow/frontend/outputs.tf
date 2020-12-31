output "frontend_instance_address" {
  value      = google_compute_instance.frontend_instance.network_interface[0].network_ip
  depends_on = [google_compute_instance.frontend_instance]
}
