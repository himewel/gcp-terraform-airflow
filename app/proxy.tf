resource "google_compute_instance" "proxy_instance" {
  name         = "proxy-instance"
  machine_type = var.machine.micro
  tags         = ["http-server"]
  allow_stopping_for_update = true
  depends_on = [time_sleep.frontend_instance_sleep]

  metadata = {
    startup-script = <<-EOF
      #!/bin/bash
      sudo apt-get update -qqq
      sudo apt-get install curl nginx -qqq
      curl https://raw.githubusercontent.com/himewel/airflow_celery_workers/main/proxy -o proxy

      server_name=$(curl -s http://whatismyip.akamai.com/)
      sed -i "s/SERVER-NAME/$server_name/g" proxy
      sed -i "s/http://127.0.0.1:8080/frontend-instance:8080/g" proxy
      sed -i "s/http://127.0.0.1:5555/frontend-instance:5555/g" proxy

      rm /etc/nginx/sites-enabled/default
      /bin/cp -rf proxy /etc/nginx/sites-available/proxy
      ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/proxy
      sudo nginx -s reload
      EOF
  }

  boot_disk {
      initialize_params {
        image = var.image
      }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {}
  }
}
