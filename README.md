# VM Fleet Commander

## Project Workflow

<div align="center">
    <img src="https://github.com/user-attachments/assets/932ab172-d8a5-4cf0-8061-87fb64c0ab6d" alt="Project Workflow Design Complete">
</div>

![Project Workflow Design (i)](https://github.com/user-attachments/assets/54991c6d-c521-4ea7-bbe4-19cf96e65976)
![Project Workflow Design (ii)](https://github.com/user-attachments/assets/1b3f086b-6c50-4887-9a3c-8d2d0b4f6fa3)
![Project Workflow Design (iii)](https://github.com/user-attachments/assets/cbd9f528-1192-4530-a7a5-91418bd2fd9f)

## Project Overview
The VM Fleet Commander project aims to implement an infrastructure-as-code approach to provision and manage virtual machines in Azure. This project uses ARM templates and Bicep to automate the deployment of Azure resources, providing hands-on experience in organizing and managing these resources efficiently.

## Objective
The main objective of this project is to gain practical experience in:
- Automating the deployment of Azure resources using ARM templates and Bicep.
- Organizing resources efficiently.
- Understanding and applying infrastructure-as-code principles.

## Prerequisites
Before starting this project, ensure you have the following:
- An active Azure subscription.
- Basic knowledge of Azure services, particularly Azure Virtual Machines and Azure Resource Manager.
- Familiarity with JSON and Bicep language syntax.
- Azure CLI installed with Bicep support.
- Git for version control.

## Azure Services Used
- Azure Virtual Machines
- Azure Resource Manager (ARM)
- Bicep

## Setup and Configuration

### Initial Setup
1. **Install Azure CLI and Bicep**:
   - Ensure Azure CLI is installed with Bicep support.
   - Verify installations using:
     ```bash
     az --version
     az bicep version
     ```
   - If a new release is available for Bicep, upgrade using:
     ```bash
     az bicep upgrade
     ```

2. **Setup Version Control (Git)**:
   - Download and install Git from [Git-scm](https://git-scm.com/download/win).
   - Verify the installation using:
     ```bash
     git --version
     ```
   - Initialize a Git repository:
     ```bash
     mkdir vm-fleet-commander
     cd vm-fleet-commander
     git init
     ```

3. **Login to Azure CLI**:
   - Use the command:
     ```bash
     az login
     ```

## Bicep Basics
I already had experience working with Bicep and ARM Templates when I was studying for my AZ-104 Exam. For revision, I used the official Bicep Documentation and AI for support in case of any doubt.

#### ARM Template to Bicep Conversion
I used a basic ARM template: `vm-template.json`

Then I used the command `az bicep decompile --file vm-template.json` in the Azure CLI to convert it to Bicep: `vm-template.bicep`

## Resource Group
I defined a Bicep file named `resource-group.bicep` to create an Azure Resource Group for the VMs.

## Virtual Machine Provisioning
I created a Bicep module in a Bicep file named `vm.bicep` for deploying Azure VMs, allowing for parameterized input like VM size, name, and region. I used loops in Bicep to deploy multiple VM instances based on a specified count and implemented naming conventions for my resources using Bicep's string functions.

Then I made a Bicep file named `main.bicep`, in which I defined parameters for customizable input values for the deployment, such as VM size, name prefix, location, admin credentials, and VM count, and referenced the `vm.bicep` module.

## Network Resources
I designed a Bicep module named `network.bicep` for associated networking resources like Virtual Network, Subnet, Network Interface Card, Public IP, and Network Security Groups.

Then I updated the `vm.bicep` so that it has Network Profile Section in it.

Then I updated the `main.bicep` so that it references the Network Resources Module also.

By doing this, I ensured that the VMs will be provisioned within the designated VNet, NIC, Public IP, and have the necessary security rules applied.

## Parameter Files and Validation
I created separate parameter files for my Bicep templates, allowing for different environment deployments (dev, test, prod).

- `dev.parameters.json`
- `test.parameters.json`
- `prod.parameters.json`

Then I used these commands to validate my Bicep files before deploying, catching any structural errors:

```bash
az deployment group validate --resource-group vmFleetRG --template-file main.bicep --parameters @dev.parameters.json
az deployment group validate --resource-group vmFleetRG --template-file main.bicep --parameters @test.parameters.json
az deployment group validate --resource-group vmFleetRG --template-file main.bicep --parameters @prod.parameters.json
```

## Deployment

I used the Azure CLI to deploy the Bicep templates, creating all designated resources.

### Step 1: Create Resource Group

Firstly, I used this command to create the resource group for the resources:

```bash
az deployment sub create --location EastUS --template-file resource-group.bicep
```

### Step 2: Deploy Resources for Development Environment

Then, I deployed the resources for the development environment using this command:

```bash
az deployment group create --resource-group vmFleetRG --template-file main.bicep --parameters @dev.parameters.json
```

### Step 3: Create and Deploy Resources for Testing Environment
After deploying the development environment, I created another resource group named "vmFleetTest" using the modified resource-group.bicep template.

Then I used this command to deploy the resources for the testing environment:

```bash
az deployment group create --resource-group vmFleetTest --template-file main.bicep --parameters @test.parameters.json
```

### Step 4: Create and Deploy Resources for Production Environment
After deploying the testing environment, I created another resource group named "vmFleetProd" using the modified resource-group.bicep template.

Then I used this command to deploy the resources for the production environment:

```bash
az deployment group create --resource-group vmFleetProd --template-file main.bicep --parameters @prod.parameters.json
```

By doing this, I tested the reproducibility by deploying the infrastructure into different environments and to different regions and resource groups. Every deployment went well and was successful.

## Maintenance & Updates
I made some changes in my dev.parameters.json file, changing the VM size from "Standard_DS1_v2" to "Standard_B1s".

Then I redeployed using this command:

```bash
az deployment group create --resource-group vmFleetRG --template-file main.bicep --parameters @dev.parameters.json
```

After the deployment, I checked the Azure portal and confirmed that the VM sizes were changed from "Standard_DS1_v2" to "Standard_B1s" for all the virtual machines.

To ensure I stay updated with new features and improvements, I regularly pull updates to the Bicep language and Azure CLI using these commands:

```bash
az upgrade
az bicep upgrade
```

## Cleanup
After testing, I ensured to delete resource groups which contained all the resources deployed throughout the project to avoid incurring unnecessary costs.

I used these commands:

```bash
az group delete --resource-group vmFleetRG
az group delete --resource-group vmFleetTest
az group delete --resource-group vmFleetProd
az group delete --resource-group NetworkWatcherRG
```

By using these commands, I ensured that every resource group containing all the resources deployed throughout the project is deleted. 
The project is completed!!!

## Conclusion

### Summary of Steps

- Reviewed and set up Azure CLI, Bicep, and Git.
- Converted ARM templates to Bicep.
- Created parameterized Bicep modules for VMs and network resources.
- Deployed resources to multiple environments.
- Validated deployments and maintained the infrastructure.
- Cleaned up resources to prevent unnecessary costs.

### Lessons Learned

- Importance of automation and parameterization in infrastructure deployment.
- Benefits of using infrastructure-as-code tools like Bicep and ARM templates.
- Effective use of Azure CLI for managing and deploying resources.

### Skills Demonstrated

- Infrastructure as Code (IaC): Proficiency in using ARM templates and Bicep to define, deploy, and manage Azure resources. Ability to convert ARM templates to Bicep, showcasing knowledge in both tools.
- Azure Resource Management: Experience in creating and managing Azure resources, including VMs, virtual networks, network security groups, and public IPs. Skill in parameterizing deployments for flexibility and scalability across different environments (development, testing, production).
- Automation: Capability to automate resource provisioning and configuration using Bicep and Azure CLI. Implementation of loops and parameterized inputs to streamline and simplify complex deployments.
- Version Control: Utilization of Git for version control to track changes and manage the project's codebase effectively.
- Deployment and Validation: Competence in deploying resources to Azure using Azure CLI commands. Thorough validation of deployment templates to ensure error-free infrastructure setup.
- Maintenance and Updates: Experience in updating deployed resources and maintaining infrastructure state. Regularly pulling updates for tools like Azure CLI and Bicep to leverage the latest features and improvements.
- Cost Management: Awareness of resource management and cost control by ensuring the deletion of unused resources post-testing.

### Repository Contents

- Manual: A detailed manual i made documenting each step of the project, including configurations, testing procedures and much more!!.
- Screenshots: Visual documentation of key stages and configurations throughout the project, providing a visual guide and reference.
- Source Code: All the source code used in this project, including the Bicep templates and parameter files, organized in the Source_Code folder.

### Contact
For any questions or further information, feel free to reach out to me on LinkedIn: https://www.linkedin.com/in/vivek-vashisht04/
