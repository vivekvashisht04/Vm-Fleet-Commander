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

Maintenance & Updates
I made some changes in my dev.parameters.json file, changing the VM size from "Standard_DS1_v2" to "Standard_B1s".

Then I redeployed using this command:
