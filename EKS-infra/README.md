STEP 1
  Install Terrafrom and Kubectl in the Jenkins srever.
  
  
   Terraform For Ubuntu/Debian.
   
  ` wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
 echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee      /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform `.

  Terraform For Amazon Linux.
  
  ` sudo yum install -y yum-utils shadow-utils
  sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
  sudo yum -y install terraform `.
  
  
  
STEP 2

  Install Kubectl.
  
  `curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" `.
  
  `curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" `.
  
  ` echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check `.  
  output is, Kubectl:ok.
  
  ` sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl `.
  
  ` chmod +x kubectl `.
  
  ` mkdir -p ~/.local/bin `.
  
  ` mv ./kubectl ~/.local/bin/kubectl `.
  
  
  
STEP 3 CREATE A JENKINS PIPELINE.

  Navigate to the Jenkins UI and create a pipeline.
  
  from the dashboard click on project, name the job select pipeline and click ok.
  
