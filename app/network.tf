resource "google_compute_network" "vpc_network" {
    name = "terraform-network"
    auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name
  source_ranges = ["0.0.0.0/0"]
  direction = "INGRESS"
  priority = "65534"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "http" {
  name    = "allow-http"
  network = google_compute_network.vpc_network.name
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["http-server"]
  direction = "INGRESS"
  priority = "1000"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_firewall" "internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc_network.name
  source_ranges = ["10.128.0.0/20", "10.142.0.0/20", "10.150.0.0/20", "10.138.0.0/20"]
  direction = "INGRESS"
  priority = "65534"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65355"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65355"]
  }
}
