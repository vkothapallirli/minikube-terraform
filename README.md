# Minikube-Terraform

HCL code to setup minikube with terraform and deploy FID

# Prerequsites
- Installed locally on your machine [Terraform cli](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Installed locally on your machine [minikube](https://minikube.sigs.k8s.io/docs/start/)

# Variables
Default workspace variables
|VARIBLE|DESCRIPTION|DEFAUL VALUE|
|---|---|---|
|minikube_cluster_name|Name of the minikube cluster profile|`minikube-terraform`|
|minikube_container_runtime|Kubernetes container runtime available `docker`,`cri-o`|`containerd`|
|minikube_nodes|Number of nodes minikube cluster can have|`2`| 
|minikube_driver|Driver to be used to create minikube cluster|`hyperv`|
|minikube_node_memory|Memory for each minikube node in MB|`4192`|
|minikube_node_cpus|CPUs for each minikube node |`2`|
|minikube_node_disk_size|Disk size for each minikube node|`20g`|
|radiantone_helm_chart_repo_url|Helm chart repo url of radiantone|`https://radiantlogic-devops.github.io/helm`|
|zookeeper_helm_chart_version|Helm chart version for zookeeper|`0.1.1`|
|fid_helm_chart_version|Helm chart version for fid|`0.1.1`|
|zookeeper_helm_chart_name|Zookeeper helm chart name in helm repo|`zookeeper`|
|fid_helm_chart_name|FID helm chart name in helm repo|`fid`|
|zookeeper_helm_release_name|Zookeeper helm release name|`zookeeper`|
|fid_helm_release_name|FID helm release name|`fid`|
|helm_release_namespace|helm release namespace|`fid-demo`|
|zookeeper_replica_count|zookeeper replica count|`3`|
|fid_replica_count|FID replica count|`1`|
|fid_root_password|FID root password|`secret1234`|
|fid_service_type|Service type for fid helm release|`ClusterIP`|
|fid_license|License key for FID|-|
|argocd|ArgoCD deploy FID and ZK with manifests from `argocd-values.yaml`. If set to `true` all the above helm release variables are ignored as manifest are present in static yaml file|`false`|

# Usage

```
# Downloads the providers
terraform init

# (Optional) Check the plan
terrafrom plan

# Install the FID stack on minikube will be prompted for license key and plan approval
terraform apply

# Install the FID stack without any input (BASH)
export LICENSE="\{rlib\}......"
terraform apply -var "fid_license=${LICENSE}" -auto-approve
# Install the FID stack without any input (CMD)
set LICENSE="\{rlib\}......"
terraform apply -var "fid_license=%LICENSE%" -auto-approve

# Destroy
terraform destroy
```

# Troubleshooting

- Error: failed to download "https://github.com/argoproj/argo-helm/releases/download/argo-cd-3.29.5/argo-cd-3.29.5.tgz"

> This error is thrown when there is `helm` installed locally on the machine, You can fix this by running `helm repo update`