#!/bin/bash
#set -x

file="./node-list.yaml"

# 설치 YAML 읽어서 변수 할당
number_of_nodes=$(yq -r ".nodes | length" $file)
ssh_key=$(yq -r ".ssh_key" $file)
master_ip=$(yq -r ".master_ip" $file)
master_hostname=$(yq -r ".master_hostname" $file)
master_ip=$(yq -r ".master_ip" $file)
kube_version=$(yq -r ".kube_version" $file)
pod_cidr=$(yq -r ".pod_cidr" $file)

echo "==============================================================="
echo "number of nodes: " $number_of_nodes
echo "ssh key file: " $ssh_key
echo "master ip: " $master_ip
echo $master_hostname
echo $master_ip
echo $kube_version
echo "==============================================================="

# 노드 정보 읽어서 변수에 할당
for (( c=0; c < $number_of_nodes; c++))
do 
  node_name[$c]=$(yq -r ".nodes[$c].name" $file)
  node_ip[$c]=$(yq -r ".nodes[$c].ip" $file)
  node_role[$c]=$(yq -r ".nodes[$c].role" $file)
  
  echo "==============================================================="
  echo "node name $c :" ${node_name[$c]}
  echo "node ip $c :" ${node_ip[$c]}
  echo "node role $c :" ${node_role[$c]}
  echo "==============================================================="
done

# 기존 설치 스크립트 삭제
rm -rf artifacts/kubeadm/scripts/*.sh

# 설치 스크립트를 템플릿에서 생성
# Create prepare.sh script
prepare_str=$(cat artifacts/kubeadm/scripts/prepare.tpl)
eval "echo \"${prepare_str}\"" > artifacts/kubeadm/scripts/prepare.sh

# Create master_init.sh script
master_init_str=$(cat artifacts/kubeadm/scripts/master_init.tpl)
eval "echo \"${master_init_str}\"" > artifacts/kubeadm/scripts/master_init.sh

# Create master_member.sh script
master_member_str=$(cat artifacts/kubeadm/scripts/master_member.tpl)
eval "echo \"${master_member_str}\"" > artifacts/kubeadm/scripts/master_member.sh

# Create worker.sh script
worker_str=$(cat artifacts/kubeadm/scripts/worker.tpl)
eval "echo \"${worker_str}\"" > artifacts/kubeadm/scripts/worker.sh


# 설치 파일, SSH키, 복사 후 마스터 노드 설치 수행
for (( c=0 ; c < number_of_nodes; c++)); 
do
  # 설치 파일 복사
  echo "====== COPYING INSTALL FILES ======"
  scp -i ${ssh_key} -r artifacts/kubeadm root@${node_ip[$c]}:/root
  scp -i ${ssh_key} ~/.ssh/id_rsa root@${node_ip[$c]}:/root/.ssh/
  ssh -i ${ssh_key} root@${node_ip[$c]} chmod +x kubeadm/scripts/*.sh

  # 컨테이너디, Kubelet 설치
  echo "====== INSTALLING CONTAIND, KUBELETS ======"
  ssh -i ${ssh_key} root@${node_ip[$c]} kubeadm/scripts/prepare.sh

  # 마스터 노드 설치
  if [[ "${node_role[$c]}" == "master" ]]
  then
    # 노드 역할이 master 인 경우 master_init.sh 실행
    echo "${node_name[$c]} :" "master"
    echo "====== SETTING MASTER NODE UP ======"
  fi
done

# 마스터 멤버 노드, 워커 노드 설치 수행
for (( c=0 ; c < number_of_nodes; c++)); 
do
  if [[ "${node_role[$c]}" == "master-member" ]]
  then
    # 노드 역할이 master_member인 경우 master_member.sh 실행
    echo "${node_name[$c]} :" "master-member"
    echo "====== SETTING MASTER MEMBER UP ======"
  elif [[ "${node_role[$c]}" == "worker" ]]
  then
    # 노드 역할이 worker 인 경우 worker.sh 실행
    echo "${node_name[$c]} :" "worker"
    echo "====== SETTING WORKER UP ======"
  else
    echo "${node_name[$c]} :" "master"
    echo "====== CHECKING MASTER NODE ======"
  fi
done
