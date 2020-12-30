resource "google_compute_instance" "worker_instance" {
  name         = "worker-instance-${count.index}"
  machine_type = var.machine.small
  allow_stopping_for_update = true
  zone = count.index > 3 ? var.zone.alternative : var.zone.alternative1
  count = var.number_of_workers
  depends_on = [time_sleep.scheduler_instance_sleep]

  metadata = {
    startup-script = <<-EOF
      #!/bin/bash
      sudo apt-get update -qqq
      sudo apt-get install docker-compose -qqq
      sudo docker run \
        --net=host \
        -e AIRFLOW__CORE__EXECUTOR=CeleryExecutor \
        -e AIRFLOW__CELERY__RESULT_BACKEND=db+postgresql://airflow:airflow@scheduler-instance:5432/airflow \
        -e AIRFLOW__CORE__SQL_ALCHEMY_CONN=postgresql+psycopg2://airflow:airflow@scheduler-instance:5432/airflow \
        -e AIRFLOW__CELERY__BROKER_URL=redis://scheduler-instance:6379/1 \
        -d apache/airflow:2.0.0-python3.8 \
        celery worker
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
