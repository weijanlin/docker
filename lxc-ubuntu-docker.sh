sudo apt update -y
sudo apt upgrade -y
sudo apt install gnupg2 -y
sudo apt install curl -y
sudo apt install software-properties-common -y
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d '=' -f 2) stable"
sudo apt update -y
sudo apt install docker-ce -y