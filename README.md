### DEVOPS Toolkit Installer

1. installer 기본 작성
2. kubeadm 기준 terraform 모듈 테스트

To-Do

1. install 변수를 terraform variables에 매핑 처리 - variables.tf 파일에 노드 정보 생성 처리
2. kubeadm 버전에 따른 large size 바이너리 download 처리 kubernetes bin 폴더에 버전별로 사전에 다운로드 하여 준비
3. tf 바이너리 다운로드 처리 => 적용 불필요 할것으로 생각되고, 사전 준비시에 일괄 준비하는 것으로 변경
4. os 버전에 따른 tf 모듈 선택 처리 => 브랜치를 나누어서 관리하는 것으로 변경 ubuntu 브랜치 생성
5. traefik ingress, cilium helm chart 다운로드 스크립트 추가

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


