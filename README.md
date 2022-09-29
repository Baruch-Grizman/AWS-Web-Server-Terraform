# Installing apache2 Web Server in AWS using Terraform  
  
Installing apache2 Web Server in AWS using Terraform\
All CI/CD is managed in CircleCI platform
  
## Description  
### An explanation of the various files in the project
  
```  
AWS-Web-Server-Terraform/  
│  
├── .circleci
│   └─── config.yml
├── commands.txt   
├── datasources.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── README.md
├── sg.tf
├── terraform.tfvars   
├── userdata.tpl   
└── variables.tf  
```   

config.yml\
CircleCI configuration will complete our jobs during the process of automating the Terraform workflow

commands.txt\
List of commands for execution

datasources.tf\
Data for creating `AWS EC2 AMI` Datasource

main.tf\
Creating the `VPC` for our future EC2 instance, define the `network`, and create the `EC2 Instance`.

outputs.tf\
Will display various values from instances, after finishing the apply process, in our example will extract the `public Ip address` of the instance we just created, so we can access it from the internet. 

providers.tf\
Setting up the `AWS Provider` with Terraform

README.md\
This is a `Markdown` file documenting the purpose and usage of our project  

sg.tf\
AWS `Security Group` to allow `ssh` and `http`

terraform.tfvars\
List of `defaults for the variables` which defined in `variables.tf` file
  
userdata.tpl\
Shell script to install the `apache server`, and configure the `index.html` file
executed whenever the instance getting initialized.\
We can provide any kind scripts in user_data like the example below,\
 -  Shell script in Unix based systems
 -  Powershell script in Windows based system

variables.tf\
List of `variables` to be using in other Resources

## Execution

 1. Clone this repository
 2. From terminal run the command `terraform init`, to initialize Terraform
 3. now run the command `terraform plan`, to make sure all correct before applying
 4. now run the command `terraform apply -auto-approve`, to start the execution plan
 5. Once done, check for the `outputs` at the end, and look for the `ip address`
 6. copy the `ip address` from previous step and paste it in your web browser.
 7. if nothing displayed, wait a few minutes, because the instance is still initializing.
 8. once done, run the command  `terraform destroy -auto-approve`, to remove all.