# Terraform build of Airflow in GCP Compute Engine

<code><img height="20" src="https://cdn.iconscout.com/icon/free/png-512/docker-226091.png"> Docker</code> +
<code><img height="20" src="https://avatars2.githubusercontent.com/u/33643075?s=280&v=4"> Airflow</code> +
<code><img height="20" src="https://docs.celeryproject.org/en/master/_static/celery_512.png"> Celery</code> +
<code><img height="20" src="https://i.pinimg.com/originals/28/ec/74/28ec7440a57536eebad2931517aa1cce.png"> Terraform</code>

The infrastructure constructed with this project consists in a set of VM instances running the services belonging to Airflow. Three main instances are builded:

1. a proxy running Nginx and redirecting the access to the Webserver UI and Flower UI;
2. the docker containers of Postgres and Redis (as a celery broker) databases together with a instance of the official image from Apache Airflow running the Scheduler service;
3. another docker container from Apache Airflow running the Webserver UI and Flower UI.

Besides these VM instances, each worker instantiated take a new VM instance running the Airflow docker image as a celery worker. To make the connection between each VM instance, a VPC and some firewall rules are setted to enable the communication in the ports 80 (http), 21 (ssh), 8080 (webserver), 5555 (flower), 5432 (postgres), 6379 (redis) and 8793 (worker logs).

# How to use

A example of `terraform.tfvars` is presented in the following code block. The variables about credentials and project ID and zone are necessairly to make the connection with the GCP project. Besides thia values, some data can be setted about login of the UIs, workers quantity, OS image of the VMs and machine types and sizes.

```hcl
credentials_filepath = <PATH TO CRDENTIALS JSON>
project_id = <PROJECT ID>
project_zone = <GCP ZONE>

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
terraform init apache-airflow
terraform apply apache-airflow
```

So, wait some moments and check the ip address outputed with the name `proxy_external_ip` in the browser. The Airflow Webserver UI can be found at the root of the addres outputed and Flower can be acessed at the location `/flower`. The terrform output should look like this:

```bash
Outputs:

proxy_external_ip = <EXTERNAL IP>
```
