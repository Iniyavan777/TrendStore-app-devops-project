set -e
apt-get update
apt-get upgrade -y
apt-get install -y openjdk-11-jdk
apt-get install -y docker.io
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get install -y jenkins
usermod -aG docker jenkins
systemctl start jenkins
systemctl enable jenkins
echo "Jenkins installation complete"
