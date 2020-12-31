output "worker_instance_address" {
  value      = google_compute_instance.worker_instance.network_interface[0].network_ip
  depends_on = [google_compute_instance.worker_instance]
}
