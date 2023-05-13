# Kubernetes Infraestructure

## How to run

To provide the kubernetes cluster you should:

- Configure the variables in "vars/main.tfvars"
- run `terraform validate`
- Run `terraform plan`
- Run `terraform plan -var-file="vars/main.tfvars"`
- Validate the information
- Run `terraform apply -var-file="vars/main.tfvars"`

## Melhorias

- [ ] Configura node pull para que escalem de maneira horizontal
- [ ] 