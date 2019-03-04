RC Pay blockchain network

##################################################################
# BN 환경구성
##################################################################

# VSCode
    # Ubuntu 접속:
        ssh -R 52698:localhost:52698 bcadmin@127.0.0.1


# Ubuntu
    # Plug-in 설치
        wget https://raw.githubusercontent.com/sclukey/rmatepython/master/bin/rmate
        chmod +x ./rmate
        mv ./rmate /usr/local/bin/rmate


# VS Code로 파일 전송
    rmate -p 52698 파일명


# curl install
    # pyhton 설치 (v2.7)
        sudo apt-get install python
    # python version 확인
        python -V


# docker install
    curl -fsSL https://get.docker.com/ | sudo sh
    sudo usermod -aG docker $(whoami)
    # (** 32bit Ubuntu 경우- 아래 2가지 방법 중 하나)
        # 1
            apt-get install docker.io)
        # 2
           sudo apt-get -y install git linux-image-extra-$(uname -r) lxc xz-utils
           git clone https://github.com/docker-32bit/ubuntu.git
           cd ubuntu
           sudo ./build-image.sh

# PIP install
    sudo apt install python-pip
    


# docker install
    curl -fsSL https://get.docker.com/ | sudo sh
    # *docker 영구 관리자 모드로 실행 (sudo 필요X)
        sudo usermod -aG docker your-user
    # (** 32bit Ubuntu 경우- 아래 2가지 방법 중 하나)
        # 1
            apt-get install docker.io)
        # 2
           sudo apt-get -y install git linux-image-extra-$(uname -r) lxc xz-utils
           git clone https://github.com/docker-32bit/ubuntu.git
           cd ubuntu
           sudo ./build-image.sh
    # version 확인 (v17이상)
        docker --version


# docker-compose install
    sudo apt-get update
    sudo apt-get upgrade
    sudo add-apt-repository universe
    sudo apt-get install -y docker-compose
    # version 확인(v1.8)
        docker-compose --version
        docker images
    # (Permission denied 발생하면 -> logout -> login)


# golang install
    # 64 bit
        wget https://dl.google.com/go/go1.10.linux-amd64.tar.gz
    # 32 bit
        wget https://dl.google.com/go/go1.10.linux-386.tar.gz
    sudo tar -xvf go1.10.linux-amd64.tar.gz
    sudo mv go /usr/local
    # 환경변수 설정
        export GOROOT=/usr/local/go
        export PATH=$PATH:$GOROOT/bin:
    # version 확인(v1.10)
        go version
    # (확인 후 go의 설치 위치 다르면 다른 위치의 디렉토리 삭제)
       which go

# node install
    # 기존버전 삭제
        sudo apt-get remove nodejs
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install -y nodejs
    # version 확인
        node --version    

# Hyperledger Fabric-samples clone
    git clone $(repository url)
	
	
#######################################################################
docker swarm
#######################################################################

# docker swarm init (manager)
    docker swarm init --advertise-addr $(private/public ip)
    # output
    
    # Worker 추가
        # 각 네트워크로 이동 후 docker swarm join --token ..... 을 입력


# swarm join token 생성 for manager
    docker swarm join-token manager
    # output
    
    # Manager 추가
        # 각 네트워크로 이동 후 docker swarm join --token ..... 을 입력
        # output
        


# 확인
    # docker info
    



######################################################
# docker network
######################################################

# docker network create
    docker network create $(network-name)
    