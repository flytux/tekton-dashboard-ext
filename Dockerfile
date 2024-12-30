FROM codercom/code-server:4.96.2
RUN  sudo apt update && sudo apt install nodejs npm vim net-tools zsh -y
# Intall Go Ko kubectl kustomize
RUN  curl -LO https://go.dev/dl/go1.23.4.linux-amd64.tar.gz &&  sudo tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz
ENV  PATH="$PATH:/usr/local/go/bin"
RUN  curl -LO https://github.com/ko-build/ko/releases/download/v0.17.1/ko_0.17.1_Linux_x86_64.tar.gz 
RUN  sudo tar xvf ko_0.17.1_Linux_x86_64.tar.gz -C /usr/local/bin
RUN  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN  sudo mv kubectl /usr/local/bin && sudo chmod +x /usr/local/bin/kubectl
RUN  curl -LO https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.5.0/kustomize_v5.5.0_linux_amd64.tar.gz
RUN  sudo tar xvf kustomize_v5.5.0_linux_amd64.tar.gz && sudo mv kustomize /usr/local/bin && sudo chmod +x /usr/local/bin/kustomize
RUN  rm -f go1.23.4.linux-amd64.tar.gz ko_0.17.1_Linux_x86_64.tar.gz kustomize_v5.5.0_linux_amd64.tar.gz
