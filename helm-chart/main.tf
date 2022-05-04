provider "kubernetes" {

  config_path = "~/.kube/config"
  config_context = "minikube"

}

resource "kubernetes_namespace" "minikube-namespace" {

  metadata {

        name = "prod"

  }

}

provider "helm" {

  kubernetes {

    config_path = "~/.kube/config"
    config_context = "minikube"

        

  }

}

resource "helm_release" "example" {

  name          = "simple-app-test"

  chart         = "/home/ubuntu/simple-app/Charts/simple-app"

  namespace     = "prod"

}