# Terraform build of Airflow in GCP Compute Engine

<code><img height="20" src="https://cdn.iconscout.com/icon/free/png-512/docker-226091.png"> Docker</code> +
<code><img height="20" src="https://avatars2.githubusercontent.com/u/33643075?s=280&v=4"> Airflow</code> +
<code><img height="20" src="https://docs.celeryproject.org/en/master/_static/celery_512.png"> Celery</code> +
<code><img height="20" src="https://i.pinimg.com/originals/28/ec/74/28ec7440a57536eebad2931517aa1cce.png"> Terraform</code>

`terraform.tfvars` example:

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

How to run:

```bash
terraform init apache-airflow
terraform apply apache-airflow
```

So, wait some moments and check the ip address outputed with the name `proxy_external_ip` in the browser. The Airflow Webserver UI can be found at the root of the addres outputed and Flower can be acessed at the location `/flower`. The terrform output should look like this:

```bash
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

proxy_external_ip = <EXTERNAL IP>
```
