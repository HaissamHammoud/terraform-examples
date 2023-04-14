# Kubernetes Infraestructure

## How to run

To provide the kubernetes cluster you should:

- Configure the variables in "vars/main.tfvars"
- run `terraform validate`
- Run `terraform plan -var-file="vars/main.tfvars"`
- Validate the information
- Run `terraform apply -var-file="vars/main.tfvars"`

## manifestos

configmap: Configuração de variaveis de ambiente não sensiveis da aplicação
deployment: Configurações do deploy da aplicação
network-policies-deny: Configuração de acesso a aplicação, permite ingress apenas do frontend.
secret: Possui os dados sensiveis da aplicação que são usados como variaveis de ambiente.
service: Possui configurações do serviço para que possa ser acessivel por outros serviços.

## To do
- [ ] Usar ferramenta como sops para criptografar o secret.
- [ ] Delimitar o uso de recursos usados pela aplicação no deployment.
- [ ] Configurar escalabilidade vertical dos pods.