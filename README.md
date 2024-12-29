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


