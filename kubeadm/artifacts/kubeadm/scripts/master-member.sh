# 01 init cluster
modprobe br_netfilter
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
chmod 400 $HOME/.ssh/id_rsa.key

until [ $(ssh -i /root/.ssh/id_rsa.key -o StrictHostKeyChecking=no 192.168.122.11 -- cat join_cmd | wc -l) != 0 ];
do
        echo "Wait Master Node Init.."
	sleep 10
done
        ssh -i /root/.ssh/id_rsa.key -o StrictHostKeyChecking=no 192.168.122.11 -- cat join_cmd | sh -

# 02 copy kubeconfig
mkdir -p $HOME/.kube
cp -ru /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# 03 install cni
kubectl taint nodes $(hostname) node-role.kubernetes.io/control-plane:NoSchedule-

