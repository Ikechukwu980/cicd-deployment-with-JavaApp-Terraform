# microservice-eks-jenkins
# Step 1 ; launch a Jenkins server using AWS EC2 instance
	- Keypair
	- Security group : SSH / Jenkins port 8080
	- Instance type: T2 small
	- Attach an IAM Role for EC2 : permission AdminFullAccess
	- Launch the service and login to the instance via SSH

# Step 2 ; installation of required software 
 `sudo hostname Jenkins`
 `sudo apt update`
 `sudo apt install maven -y`
** Jenkins setup **
- Add Repository key to the system
`curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null`
	
Append debian package repo address to the system
`echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
 https://pkg.jenkins.io/debian binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null`
 `sudo apt update`
 `sudo apt install Jenkins -y`
** then access the Jenkins server via the server public_dns_name:8080
- Get the initial password from the below file
`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
- Copy and paste in the browser
- Click install plug-ins
- Create username and password 
- Click save and finish.

# Step 3: install AWS CLI 
  `curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" `
   `sudo apt install unzip`
   `sudo unzip awscliv2.zip`  
   `sudo ./aws/install`
   `aws --version`

** installing EKSCLI **
  `curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp`
   Move the extracted binary to /usr/local/bin. 
  `sudo mv /tmp/eksctl /usr/local/bin`
  `eksctl version`

** installing Kubectl **
  `sudo curl --silent --location -o /usr/local/bin/kubectl   https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl`

** To give the kubectl file execution permission
  `sudo chmod +x /usr/local/bin/kubectl`

** Install Terraform **
` wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform `

# Step 
	- sudo su - Jenkins
** to view the kubeconfig file  **
	- cat  /var/lib/jenkins/.kube/config
	- Kubectl get nodes               ** view worker nodes **
	- Kubectl get ns                      ** view namespaces **



# Step 5: installing docker on the Jenkins server
** installing docker on the Jenkins server **
` sudo apt install docker.io -y `
` sudo usermod -aG docker $USER `
 - Exit and log back in
` sudo systemctl start docker `
` sudo systemctl enable docker `
` sudo systemctl status docker `

** add jenkins user to docker group **
` sudo usermod -a -G docker jenkins `
` sudo service jenkins restart `
` sudo systemctl daemon-reload `
` sudo service docker stop `
` sudo service docker start ` 

# Step 6: install plug-ins inside your Jenkins UI
     Navigate to manage Jenkins  and click manage plug-ins
	- Select Available 
	- Search for docker( select docker and docker pipeline)
	- Search for Kubernetes ( Kubernetes cli )
	- Install without restart.

# Step 6: start building the Jenkins pipeline
	 - Create maven3 variable under global tool configuration in Jenkins( to build the java file )
	 - Navigate to manage Jenkins and click on global tool configuration
	 - Scroll down and click on add maven
	 - Name: maven3
	 - Maven_home : /usr/share/maven
	 - Click save and apply

** Create Credentials for connecting to Kubernetes Cluster using kubeconfig
   	  After the cluster is created check the cluster
	  `Kubectl get nodes`
	  Get cluster --name demo-eks --region us-east-1
	 `cat /var/i\lib/jenkins/.kube/config`
	  copy and store in a txt-file
	  Navigate to Jenkins dashboard and click on manage Jenkins
	  Manage credentials click on add credentials
	  Select Secret file and select the file we just cpy
      Add id and description k8s and k8s


** create Jenkins pipeline
	  - From Jenkins dashboard click on project
	  - Name the job and click on pipeline and ok
	  - Click on pipeline and select the dropdown to select hello world
	  - First stage is (checkout)
	  - Click on pipeline syntax at the bottom 
	  - Select checkout with version control
	  - Branch main and git url  paste it and click apply and save.
	  - Second stage is ( build jar file )
	
	


	





