resource "google_compute_instance" "frontend_instance" {
  name         = "frontend-instance"
  machine_type = var.machine.small
  zone = var.zone.default
  allow_stopping_for_update = true
  depends_on = [time_sleep.scheduler_instance_sleep]

  metadata = {
    startup-script = <<-EOF
      #!/bin/bash

      sudo apt-get update -qqq
      sudo apt-get install docker-compose -qqq

      docker_id=$(sudo docker run \
        --net=host \
        -e AIRFLOW__CORE__EXECUTOR=CeleryExecutor \
        -e AIRFLOW__CELERY__RESULT_BACKEND=db+postgresql://airflow:airflow@${google_compute_instance.scheduler_instance.network_interface[0].network_ip}:5432/airflow \
        -e AIRFLOW__CORE__SQL_ALCHEMY_CONN=postgresql+psycopg2://airflow:airflow@${google_compute_instance.scheduler_instance.network_interface[0].network_ip}:5432/airflow \
        -e AIRFLOW__CELERY__BROKER_URL=redis://${google_compute_instance.scheduler_instance.network_interface[0].network_ip}:6379/1 \
        -d apache/airflow:2.0.0-python3.8 \
        airflow webserver -p 8080)

      sudo docker exec -d $docker_id \
        airflow celery flower \
            -p 5555 \
            -u /flower \
            -A ${var.flower.username}:${var.flower.password}
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

resource "time_sleep" "frontend_instance_sleep" {
  create_duration = "60s"
  depends_on = [google_compute_instance.frontend_instance]
}
