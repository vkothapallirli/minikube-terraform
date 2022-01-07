provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = var.minikube_cluster_name
  }
}

resource "helm_release" "argocd" {
  count      = var.argocd ? 1 : 0
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  values = [
    "${file("argocd-values.yaml")}"
  ]

}

resource "helm_release" "zookeeper" {
  count            = var.argocd ? 0 : 1
  name             = var.zookeeper_helm_release_name
  repository       = var.radiantone_helm_chart_repo_url
  chart            = var.zookeeper_helm_chart_name
  version          = var.zookeeper_helm_chart_version
  namespace        = var.helm_release_namespace
  create_namespace = true
  depends_on = [
    null_resource.minikube
  ]
  set {
    name  = "replicaCount"
    value = var.zookeeper_replica_count
  }
}


resource "helm_release" "fid" {
  count      = var.argocd ? 0 : 1
  name       = var.fid_helm_release_name
  repository = var.radiantone_helm_chart_repo_url
  chart      = var.fid_helm_chart_name
  version    = var.fid_helm_chart_version
  namespace  = var.helm_release_namespace
  timeout    = "1200"
  depends_on = [
    helm_release.zookeeper
  ]
  set {
    name  = "zk.connectionString"
    value = "${var.zookeeper_helm_release_name}.${var.helm_release_namespace}:2181"
  }

  set {
    name  = "zk.ruok"
    value = "http://${var.zookeeper_helm_release_name}.${var.helm_release_namespace}:8080/commands/ruok"
  }

  set_sensitive {
    name  = "fid.license"
    value = var.fid_license
  }

  set_sensitive {
    name  = "fid.rootPassword"
    value = var.fid_root_password
  }

  set {
    name  = "replicaCount"
    value = var.fid_replica_count
  }

  set {
    name  = "service.type"
    value = var.fid_service_type
  }

}

