# 01 init cluster
modprobe br_netfilter
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
chmod 400 /root/.ssh/id_rsa

until [ 3 != 0 ];
do
        echo Wait Master Node Init..
	sleep 10
done
        ssh -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no 192.168.122.38 -- cat join_cmd | sh -

# 02 copy kubeconfig
mkdir -p /root/.kube
cp -ru /etc/kubernetes/admin.conf /root/.kube/config
chown 0:0 /root/.kube/config

# 03 install cni
kubectl taint nodes kw01 node-role.kubernetes.io/control-plane:NoSchedule-
