### DEVOPS Toolkit Installer

1. installer 기본 작성
2. kubeadm 기준 terraform 모듈 테스트

To-Do

1. install 변수를 terraform variables에 매핑 처리 - 1차 작업 완료
2. kubeadm 버전에 따른 large size 바이너리 download 처리 
3. tf 바이너리 다운로드 처리
4. os 버전에 따른 tf 모듈 선택 처리
5. traefik ingress > nginx ingress 변경 처리

### Tekton Dashboard Extention 

#### 1. Setup code-server tekton dev environments
```
Dockerfile
# 코드 서버 내 테크톤 빌드를 위한 툴킷을 설치하고 클러스터 내 구동합니다.
# Install Go, Ko, Kubectl, Git, Kustomize

```

#### 2. Install docker registry 
```
# ko 빌드를 위한 사설 레지스트리를 설치하고, 레지스트리 주소를 설정합니다.
# Install docker registry

# login to docker registry

# export KO_DOCKER_REPO='docker.local' # 레파지토리 주소

# run installer (https://github.com/tektoncd/dashboard/blob/main/docs/dev/installer.md#before-you-begin)
```


