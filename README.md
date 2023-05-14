# CICD with jenkins-maven-sonarqube-docker-Eks-Terraform-Promethues-Grafana
# Step 1 ; launch a Jenkins server using AWS EC2 instance
 	- Ubuntu 2
	- Jenkins and Sonarqube servers
	- Keypair
	- Security group : SSH / Jenkins port 8080 and Sonarqube port 9000
	- Instance type: T2 large for Jenkins and T2 medium for sonarqube
	- Attach an IAM Role for EC2 : permission AdminFullAccess
	- Launch the service and login to the instance via SSH

# Step 2 ; installation of required software

 `sudo hostname Jenkins`
 
 `sudo apt update`
 
 `sudo apt install maven -y`
 
** Jenkins setup **

`curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins`

` systemctl status jenkins `
 
** then access the Jenkins server via the server public_dns_name:8080 **

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

# Step 4: installing docker on the Jenkins server

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

# Step 5: install plug-ins inside your Jenkins UI
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

** Create Credentials for connecting to Kubernetes Cluster using kubeconfig **

   	  After the cluster is created check the cluster
	  
	  `Kubectl get nodes`
	  
	 `cat /var/i\lib/jenkins/.kube/config`
	 
	  copy and store in a txt-file
	  
	  Navigate to Jenkins dashboard and click on manage Jenkins
	  
	  Manage credentials click on add credentials
	  
	  Select Secret file and select the file we just cpy
	  
      Add id and description k8s and k8s


** create Jenkins pipeline **
	  - From Jenkins dashboard click on project
	  - Name the job and click on pipeline and then ok
	  
** Access the Sonarqube server with the public IP:9000 and click login
	Username: admin
	Password: admin
	- select create a project 
	- project: JavaWebApp
	- Enter a name for your token: Jenkins and click generate and click continue
	- select java and select maven
	- copy the generated command and paste it on the Jenkinsfile at the sorna-scanner stage
	
	
	
# Step 8, After the cluster is created we can setup the prometheus and grafana.

   ** install helm chart to the Jenkins server **
   
	`curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3`
	
	`sudo chmod 700 get_helm.sh`
	
	`sudo ./get_helm.sh`
	
	`helm version --client`
	
** to add the helm sable chart to my local **

	`helm repo add stable https://charts.helm.sh/stable`
	
** Add the prometheus repo **

	`helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`
	
	`helm search repo prometheus-community`
	
** create prometheus namespace **

	`kubectl create namespace prometheus`
	
** install the kube-prometheus-stack **

	`helm install stable prometheus-community/kube-prometheus-stack -n prometheus`
	
	`kubectl get pods -n prometheus`
	
	`kubectl get svc -n prometheus`
	
** Edit the prometheus and grafana service **

	`kubectl edit svc stable-kube-prometheus-sta-prometheus -n prometheus`
	
	change the service to 'LoadBalancer'
	
	`kubectl edit svc stable-grafana -n prometheus`
	
	`kubectl get svc -n prometheus`

# STEP 8, Access the Grafana UI in the browser
 - copy the LoadBalancer URL and paste it on the browser
 - UserName: admin
 - password: prom-operator
 
 ** create a dashboard in grafana
 - Click '+' button on left panel and select ‘Import’.
 - Enter 12740 dashboard id under Grafana.com Dashboard.
 - Click ‘Load’.
 - Select ‘Prometheus’ as the endpoint under prometheus data sources drop down.
 - Click ‘Import’.

 ** Create POD Monitoring Dashboard
 - Click '+' button on left panel and select ‘Import’.
 - Enter 6417 dashboard id under Grafana.com Dashboard.
 - Click ‘Load’.
 - Select ‘Prometheus’ as the endpoint under prometheus data sources drop down.
 - Click ‘Import






	

	


	





