# Terraform build of Airflow in GCP Compute Engine

<p>
<img alt="Docker" src="https://img.shields.io/badge/docker-%230db7ed.svg?&style=for-the-badge&logo=docker&logoColor=white"/>
<img alt="Apache Airflow" src="https://img.shields.io/badge/apacheairflow-%23017cee.svg?&style=for-the-badge&logo=apache-airflow&logoColor=white"/>
<img alt="Celery" src="https://img.shields.io/badge/celery-%2337814A.svg?&style=for-the-badge&logo=celery&logoColor=white"/>
<img alt="Google Cloud" src="https://img.shields.io/badge/GoogleCloud-%234285F4.svg?&style=for-the-badge&logo=google-cloud&logoColor=white"/>
<img alt="Terraform" src="https://img.shields.io/badge/terraform-%23623CE4.svg?&style=for-the-badge&logo=terraform&logoColor=white"/>
</p>

The infrastructure constructed with this project consists in a set of VM instances running the services belonging to Airflow. Three main instances are builded:

1. a proxy running Nginx and redirecting the access to the Webserver UI and Flower UI;
2. the docker containers of Postgres and Redis (as a celery broker) databases together with a instance of the official image from Apache Airflow running the Scheduler service;
3. another docker container from Apache Airflow running the Webserver UI and Flower UI.

Besides these VM instances, each worker instantiated take a new VM instance running the Airflow docker image as a celery worker. To make the connection between each VM instance, a VPC and some firewall rules are setted to enable the communication in the ports 80 (http), 21 (ssh), 8080 (webserver), 5555 (flower), 5432 (postgres), 6379 (redis) and 8793 (worker logs).

# How to use

A example of `terraform.tfvars` is presented in the following code block. The credentials in GCP need to be provided by `gcloud auth login`, you can use `make gcloud`. Besides these values, some data can be setted about login of the UIs, workers quantity, OS image of the VMs and machine types and sizes:

```hcl
number_of_workers = 4
webserver = {
    username = "admin"
    password = "admin"
    firstname = "Welbert"
    lastname = "Castro"
    email = "welberthime@hotmail.com"
    role = "Admin"
}
flower = {
    username = "admin"
    password = "admin"
}
```

To build this project, run with terraform the setup of providers and modules and then, apply the infrastructure configured:

```bash
# build docker container
make build
# start terraform daemon
make start
# enter into the shell container
make shell

# terraform workflow
terraform init apache-airflow
terraform plan apache-airflow
terraform apply apache-airflow
```

So, wait some moments and check the ip address outputed with the name `proxy_external_ip` in the browser. The Airflow Webserver UI can be found at the root of the addres outputed and Flower can be acessed at the location `/flower`. The terrform output should look like this:

```bash
Outputs:

proxy_external_ip = <EXTERNAL IP>
```
