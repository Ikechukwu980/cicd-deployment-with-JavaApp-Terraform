# STEP 1
 # Installing Terrafrom,Kubectl and Checkov scan in the Jenkins server.
 
 ![Infra diagram](https://github.com/Ikechukwu980/cicd-deployment-with-JavaApp-Terraform/assets/106882590/e891883e-3160-42e4-9653-6d88eb1c3905)
 
  # Terraform For Ubuntu/Debian.
   -  sudo apt install curl
   - curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
   - sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
   - sudo apt update 
   - sudo apt-get install terraform 
   - terraform --version

 # Terraform For Amazon Linux.
  
- sudo yum install -y yum-utils shadow-utils
  sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
  sudo yum -y install terraform
  
# STEP 2

 # Install Kubectl.
  - curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 
  - curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" 
  - echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check `.  
  - output is, Kubectl:ok.
  
  - sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl 
  - chmod +x kubectl 
  - mkdir -p ~/.local/bin 
  - mv ./kubectl ~/.local/bin/kubectl

# Install Checkov 
 - sudo apt update
 - sudo apt install python3-pip
 - sudo pip3 install checkov
 - checkov -v
  
  # STEP 3 CREATE A JENKINS PIPELINE.
 # Navigate to the Jenkins UI and create a pipeline.
    - Click on **New Item**
    - Enter an item name: **infra-pipeline** & select the category as **Pipeline**
    - Now scroll-down and in the Pipeline section --> Definition --> Select Pipeline script from SCM
    - SCM: **Git**
    - Repositories
        - Repository URL: FILL YOUR OWN REPO URL (that we created by importing in the first step)
        - Branch Specifier (blank for 'any'): */main
        - Script Path: Jenkinsfile
    - Save
  
  
  
  # STEP 4 AFTER THE EKS CLUSTER IS CREATED,
  
   - Copy the kubeconfig file to ~/.kube/config
  
  # This command will update the kubeconfig file into the default location ~/.kube/config
  - aws eks update-kubeconfig --name <cluster_name> 
  - kubectl get nodes
  - kubectl get all 
  - kubectl get cluster --name <name of cluster> --region us-west-2

  
