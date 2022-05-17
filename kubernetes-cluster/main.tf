terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = "token do"
}


resource "digitalocean_kubernetes_cluster" "cluster-test" {
  name   = var.hostname
  region = "sgp1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.21.9-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-8vcpu-16gb"
    node_count = var.node_count

    taint {
      key    = "workloadKind"
      value  = "database"
      effect = "NoSchedule"
    }
  }
}


resource "digitalocean_loadbalancer" "public" {
  name   = "loadbalancer-1"
  region = "sgp1"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }
}
