variable "minikube_cluster_name" {
  default = "minikube-terraform"
}

variable "minikube_node_memory" {
  default = "4192"
}

variable "minikube_node_cpus" {
  default = "2"
}

variable "minikube_driver" {
  default = "hyperv"
}

variable "minikube_nodes" {
  default = "2"
}

variable "minikube_node_disk_size" {
  default = "20g"
}

variable "minikube_container_runtime" {
  default = "containerd"
}

variable "argocd" {
  default     = false
  description = "If argocd is enabled FID and Zookeeper deployment is handled by argocd. FID or ZK helm arguments have to be modified in argocd-values.yaml but not in terraform variables"
}

variable "radiantone_helm_chart_repo_url" {
  default = "https://radiantlogic-devops.github.io/helm"
}

variable "zookeeper_helm_release_name" {
  default = "zookeeper"
}

variable "fid_helm_release_name" {
  default = "fid"
}

variable "zookeeper_helm_chart_version" {
  default = "0.1.1"
}

variable "fid_helm_chart_version" {
  default = "0.1.1"
}

variable "zookeeper_helm_chart_name" {
  default = "zookeeper"
}

variable "fid_helm_chart_name" {
  default = "fid"
}

variable "helm_release_namespace" {
  default = "fid-demo"
}

variable "zookeeper_replica_count" {
  default = "3"
}

variable "fid_replica_count" {
  default = "1"
}

variable "fid_root_password" {
  default   = "secret1234"
  sensitive = true
}

variable "fid_service_type" {
  default = "ClusterIP"
}

variable "fid_license" {
  sensitive = true
}