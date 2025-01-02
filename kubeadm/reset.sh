#!/bin/bash

for node in node-01 node-02 
do
  echo "==== kubeadm reset $node ===="
  ssh -i ../idrsa root@$node kubeadm reset --force
  echo "==== clean cni plugins & iptables $node ===="
  ssh -i ../idrsa root@$node rm -rf kubeadm && rm -rf /etc/cni/net.d 
done
