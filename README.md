# Simple terraform example
A simple modular template for AWS functionalities with terraform
At the moment the repositry contains only a simple lambda example using a lambda with cloudwatch events.

I dont recomend using private and acces keys on plain text on real life projects, and if you use it for test purpose, make sure to change it to avoid billing problems on the future.

To run , just use:
Run:
(note i use a file "secrets.tfvars" for this example)
- terraform init 
- terraform plan --var-file="secrets.tfvars" -state="app.tfstate"
- terraform apply --var-file="secrets.tfvars"  -state="app.tfstate"

This repository contains only personal templates and i dont have responsability over bad use of it.

To destroy everything:
- terraform destroy --var-file="secrets.tfvars"  -state="app.tfstate"
