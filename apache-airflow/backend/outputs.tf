output "backend_instance_address" {
  value      = google_compute_instance.backend_instance.network_interface[0].network_ip
  depends_on = [time_sleep.backend_instance_sleep]
}
