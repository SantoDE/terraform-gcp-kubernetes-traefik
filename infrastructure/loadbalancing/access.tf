resource "kubernetes_service_account" "traefik" {
  metadata {
    namespace = "${kubernetes_namespace.loadbalancing.metadata.0.name}"
    name      = "traefik-ingress-controller"
  }
}
