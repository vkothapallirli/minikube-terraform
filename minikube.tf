resource "null_resource" "minikube" {

  triggers = {
    cluster_name = var.minikube_cluster_name
  }

  provisioner "local-exec" {
    command = "minikube start --memory=${var.minikube_node_memory} --cpus=${var.minikube_node_cpus} --driver=${var.minikube_driver} --nodes=${var.minikube_nodes} --disk-size=${var.minikube_node_disk_size} --container-runtime=${var.minikube_container_runtime} --profile=${var.minikube_cluster_name} --addons=metallb --addons=metrics-server"
  }



  provisioner "local-exec" {
    when    = destroy
    command = "minikube delete --profile=${self.triggers.cluster_name}"
  }

}