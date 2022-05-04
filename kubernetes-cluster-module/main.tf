terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

module "test" {
  source = "./modules/"

  do_k8s_name       = "kubernetes-test"
}

