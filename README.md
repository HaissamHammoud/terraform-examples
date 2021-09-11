# lambda-with-terraform
A simple aws lambda function made using terraform automation


To run , just use:
Run:
- terraform init 
- terraform plan --var-file="secrets.tfvars" -state="app.tfstate"
- terraform apply --var-file="secrets.tfvars"  -state="app.tfstate"

Take care, never use this in production!!!

- terraform destroy --var-file="secrets.tfvars"  -state="app.tfstate"