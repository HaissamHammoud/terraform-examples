# this is a resource to test out infrastructure
# here we can recieve a list of namespaces and deman it to make all tha namespaces wanter by changing de values on it dinamically 
# eg default_namespaces = [ application, monitoring]

# data "template_file" "namespaces" {
#   count = var.namespaces
#   template = file("${path.module}/manifest/namespace.yaml.tpl")
#   vars = {
#     namespace = var.namespaces[count.index]
#   }
# }
# 
# resource "kubernetes_manifest" "application-namespace" {
#     count = template_file.namespaces
#     provider=kubernetes
#     manifest = yamldecode(file(template_file[count.index]))
# }
