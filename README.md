# Terraform build of Airflow in GCP Compute Engine

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
terraform init app
terraform apply app
```

So, wait some moments and check the ip address outputed with the name `proxy_external_ip` in the browser. The Airflow Webserver UI can be found at the root of the addres outputed and Flower can be acessed at the location `/flower`. The terrform output should look like this:

```bash
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

proxy_external_ip = <EXTERNAL IP>
```
