resource "kubernetes_namespace" "loadbalancing" {
  metadata {
    name = "loadbalancing"
  }
}

resource "kubernetes_service" "traefik" {
  metadata {
    namespace = "${kubernetes_namespace.loadbalancing.metadata.0.name}"
    name      = "traefik"
  }

  spec {
    selector {
      run = "traefik"
    }

    session_affinity = "ClientIP"

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
      name        = "http"
    }

    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
      name        = "dashboard"
    }

    type             = "LoadBalancer"
    load_balancer_ip = "${google_compute_address.default.address}"
  }
}

resource "kubernetes_replication_controller" "traefik" {
  metadata {
    name      = "traefik"
    namespace = "${kubernetes_namespace.loadbalancing.metadata.0.name}"

    labels {
      run = "traefik"
    }
  }

  spec {
    selector {
      run = "traefik"
    }

    template {
      service_account_name = "${kubernetes_service_account.traefik.metadata.0.name}"

      volume {
        name = "${kubernetes_service_account.traefik.default_secret_name}"

        secret {
          secret_name = "${kubernetes_service_account.traefik.default_secret_name}"
        }
      }

      container {
        image = "traefik:latest"
        name  = "traefik"
        args  = ["--api", "--kubernetes", "--logLevel=DEBUG"]

        volume_mount {
          mount_path = "/var/run/secrets/kubernetes.io/serviceaccount"
          name       = "${kubernetes_service_account.traefik.default_secret_name}"
          read_only  = "false"
        }
      }
    }
  }
}
