resource "kubernetes_manifest" "deployment" {
    provider=kubernetes
    manifest = yamldecode(file("manifest/deployment.yaml"))
}

resource "kubernetes_manifest" "configmap" {
    provider=kubernetes
    manifest = yamldecode(file("manifest/configmap.yaml"))
}

resource "kubernetes_manifest" "secret" {
    provider=kubernetes
    manifest = yamldecode(file("manifest/secret.yaml"))
}

resource "kubernetes_manifest" "service" {
    provider=kubernetes
    manifest = yamldecode(file("manifest/service.yaml"))
    computed_fields = ["spec.loadBalancerIP"]
}

resource "kubernetes_manifest" "backend_network_policie" {
    provider=kubernetes
    manifest = yamldecode(file("manifest/network-policies-deny.yaml"))
}
