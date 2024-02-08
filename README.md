# Three-tier Architecture Automation using Terraform

This repository automates the deployment process of a three-tier architecture in AWS using Terraform.

## Usage

### Setup

Before proceeding with the deployment, ensure you review and configure the necessary variables in the `variables.tf` file according to your requirements. All variables must be defined to avoid errors during deployment.

Initialize Terraform in the project directory by running the following command:

```bash
terraform init
```

### Deployment

Once Terraform is initialized, execute the `main.tf` file to deploy the architecture:

```bash
terraform apply
```

## Overview

This Terraform code accomplishes the following tasks:

- Creates a Virtual Private Cloud (VPC) with the specified CIDR block in the chosen AWS region.
- Establishes subnets for each layer of the architecture.
- Sets up an Internet Gateway (IGW) and NAT Gateway.
- Configures route tables.
- Deploys a Relational Database Service (RDS) instance.
- Defines security groups for the web layer.
- Launches EC2 instances for web servers.
- Sets up an Application Load Balancer. 

For detailed instructions and explanations, refer to the comments within the Terraform configuration files.
