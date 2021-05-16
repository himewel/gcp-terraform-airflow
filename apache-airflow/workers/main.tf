resource "google_compute_instance" "worker_instance" {
  name                      = var.instance_name
  machine_type              = var.machine.small
  allow_stopping_for_update = true
  zone                      = var.zone

  metadata = {
    startup-script = <<-EOF
      #!/bin/bash
      sudo apt-get update -qqq
      sudo apt-get install docker-compose -qqq
      sudo docker run \
        --net=host \
        -e AIRFLOW__CORE__EXECUTOR=CeleryExecutor \
        -e AIRFLOW__CELERY__RESULT_BACKEND=db+postgresql://airflow:airflow@${var.backend_instance_address}:5432/airflow \
        -e AIRFLOW__CORE__SQL_ALCHEMY_CONN=postgresql+psycopg2://airflow:airflow@${var.backend_instance_address}:5432/airflow \
        -e AIRFLOW__CELERY__BROKER_URL=redis://${var.backend_instance_address}:6379/1 \
        -d apache/airflow:2.0.1-python3.8 \
        celery worker
      EOF
  }

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.vpc_network_name
    access_config {}
  }
}
