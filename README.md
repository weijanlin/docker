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
