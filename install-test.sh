#!/bin/bash

#
# Variables
# k8s_platform_type 1) kubeadm 2) rke2
# node_number 노드 갯수
# node_os 노드 OS 1) rocky 2) ubuntu
# node_ips[] 노드 IP 배열
# node_hostnames[] 노드 호스트이름 배열
# node_roles[] 노드 역할 배열 ex) master, master-member, worker
# root password 


echo "DEVOPS Installer"

# 클러스터 플랫폼 선택
read -p "설치할 플랫폼을 선택하세요 1) kubeadm 2) rke2 ? " k8s_platform_type

if [ $k8s_platform_type == 1 ]; then
  echo "Installing : kubeadm"
elif [ $k8s_platform_type == 2 ]; then
  echo "Installing : rke2"
else 
  echo "Please select kubeadm or rke2"
fi


# 클러스터 노드 정보 입력
read -p "노드 갯수는 몇개 인가요 ? " node_number

read -p "노드 OS는 무엇인가요 ? 1) rocky 2) ubuntu " node_os

for (( c=0; c<$node_number; c++ )); do
    read -p "IP는 무엇인가요? " node_ip
    node_ips[$c]=$node_ip
    echo ${node_ips[$c]}

    read -p "Host명은 무엇인가요? " node_hostname
    node_hostnames[$c]=$node_hostname

    read -p "역할은 무엇안가요? " node_role
    node_roles[$c]=$node_role
        
    echo "================노드 정보================"
    echo "($(($c+1)))" ${node_hostnames[$c]} " : " ${node_ips[$c]} " : " ${node_roles[$c]}
done

# ssh 키 생성
echo "================ SSH key 생성 ================"
read -p "키파일 이름을 지정하세요. " ssh_key_filename
ssh-keygen -f $ssh_key_filename -N ""

# ssh-key 추가

for (( c=0; c<$node_number; c++ )); do
set -x
  ssh-keygen -f '$HOME/.ssh/known_hosts' -R '${node_ips[$c]}'
  ssh-copy-id -i $ssh_key_filename root@${node_ips[$c]}
set +x
done