variable "kube_version" {default = "v1.30.4" }

variable "ssh_key" {default = "../idrsa"}

variable "master_ip" { default = "192.168.122.11" }

variable "master_hostname" { default = "k8smaster" }

variable "pod_cidr" { default = "10.244.0.0/16" }

variable "kubeadm_home" { default = "artifacts/kubeadm" }

variable "kubeadm_nodes" { 

  type = map(object({ role = string, ip = string }))
  default = { 
# install 스크립트에서 추가하므로 아래 삭제
    node-01 = { role = "master", ip = "192.168.122.11" },
   }
}
