LXC 安裝 Docker CE
===

# LXC　預設ssh root 仍是disable ,所以要先打開 
安裝後可以修改一些 ssh 的設定, 如port, 密碼認證, root登入等
>vi /etc/ssh/sshd_config
```
Port 22
PasswordAuthentication yes
PermitRootLogin yes -> 是否開放 root 登入
```
更改完存檔後記得重啟服務
```
# /etc/init.d/ssh restart
```

# LXC 預設仍沒有裝git 所以仍須安裝git
```
sudo apg-get update -y 
sudo apt-get install git -y
```
# Docker Login
要登入才能用Dockerfile
輸入 https://hub.docker.com/ 的帳號及密碼若沒有要去註冊一個
```
docker login
```
若登入成功會出現
```
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```
# 用lxc 產生ssh key 給gitlab.com
> 不然無法接下來專案哦
# 建立Dockerfile
以maxaiot 的rad 專案為例
```
FROM ubuntu:18.04
RUN apt-get update -y \
    && apt-get install -y wget \
    && wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get install -y apt-transport-https \
    && apt-get update -y \
    && apt-get install -y dotnet-sdk-3.1 \
    && apt-get install -y vim curl git \
    && mkdir /opt/RAD 
COPY web .
RUN dotnet restore \
    && dotnet build -c Release \
    && dotnet publish -c Release 'Presentation/Rad.Api/RAD.Api.csproj' -o  'dist/api' \
    && cp -ruv dist/api/* /opt/RAD/ \
    && chmod -R 777 /opt/RAD
WORKDIR /opt/RAD
ENTRYPOINT ["dotnet", "/opt/RAD/RAD.Api.dll", "--urls", "http://+80"]


```
