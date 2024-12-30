#!/bin/bash

for node in node-01 node-02 
do
  echo "==== kubeadm reset ===="
  ssh -i ../idrsa root@$node kubeadm reset --force
  echo "==== clean cni plugins & iptables ===="
  ssh -i ../idrsa root@$node rm -rf kubeadm && rm -rf /etc/cni/net.d 
done
