# VM Fleet Commander

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

### Bicep Basics
I already had experience working with Bicep and ARM Templates when I was studying for my AZ-104 Exam. For revision, I used the official Bicep Documentation and AI for support in case of any doubt.

#### ARM Template to Bicep Conversion
I used a basic ARM template: `vm-template.json`

Then I used the command `az bicep decompile --file vm-template.json` in the Azure CLI to convert it to Bicep: `vm-template.bicep`

### Resource Group
I defined a Bicep file named `resource-group.bicep` to create an Azure Resource Group for the VMs.

### Virtual Machine Provisioning
I created a Bicep module in a Bicep file named `vm.bicep` for deploying Azure VMs, allowing for parameterized input like VM size, name, and region. I used loops in Bicep to deploy multiple VM instances based on a specified count and implemented naming conventions for my resources using Bicep's string functions.

Then I made a Bicep file named `main.bicep`, in which I defined parameters for customizable input values for the deployment, such as VM size, name prefix, location, admin credentials, and VM count, and referenced the `vm.bicep` module.

### Network Resources
I designed a Bicep module named `network.bicep` for associated networking resources like Virtual Network, Subnet, Network Interface Card, Public IP, and Network Security Groups.

Then I updated the `vm.bicep`.

Then I updated the `main.bicep` so that it references the Network Resources Module also.

By doing this, I ensured that the VMs will be provisioned within the designated VNet, NIC, Public IP, and have the necessary security rules applied.

### Parameter Files and Validation
I created separate parameter files for my Bicep templates, allowing for different environment deployments (dev, test, prod).

- `dev.parameters.json`
- `test.parameters.json`
- `prod.parameters.json`

Then I used these commands to validate my Bicep files before deploying, catching any structural errors:
```bash
az deployment group validate --resource-group vmFleetRG --template-file main.bicep --parameters @dev.parameters.json
az deployment group validate --resource-group vmFleetRG --template-file main.bicep --parameters @test.parameters.json
az deployment group validate --resource-group vmFleetRG --template-file main.bicep --parameters @prod.parameters.json
