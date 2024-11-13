# Online-Learning-Platform

This repository contains the code and documentation for setting up a scalable and secure infrastructure for an online learning platform on Amazon Web Services (AWS). The infrastructure is deployed using Infrastructure as Code (IaC) principles, with a focus on scalability, security, and automation.

# Methodology
The construction of the online learning platform infrastructure is organized into four phases:

Design: Prepare and confirm the design of the infrastructure.
Build and Deploy: Write Infrastructure as Code (IaC) using Terraform and deploy it using AWS CI/CD pipeline.
Document:
Provide a Readme.md file explaining how to create the infrastructure and run the CI/CD pipeline.
Provide an infrastructure runbook detailing operational procedures.
Demo: Prepare a small demo script demonstrating the deployment and operation of the infrastructure and provide a video recording showcasing the deployment.

# General Requirements
Map out the system architecture using draw.io.
Generate an IAM user with the necessary permissions for this specific infrastructure.
Implement an AWS CI/CD pipeline for continuous update deployment.
Construct Terraform code that follows the AWS Well-Architected Framework, focusing on scalability and security. Organize Terraform resources in modules.
Create a Bastion server to access the DB Server.

# AWS Resources Used

VPC
S3 (for course materials and videos)
EC2 (t2.micro for application servers)
RDS (PostgreSQL engine for student data)
DynamoDB (for course progress tracking)
EFS (for shared resources among students)
CloudWatch
Autoscaling Group
Load Balancer (Application Load Balancer)

# Specific Technical Requirements

Security:
Implement Security Groups for RDS instances to restrict access, allowing only specific ports.
Configure NACLs with custom rules for different subnets.
Autoscaling:
Maintain a minimum of 1 instance, scale up to 2 based on CPU and memory usage.
Monitoring & Log Retention:
Utilize CloudWatch for system and application logs with 2 days retention.
Enable RDS performance insights for monitoring.
Database Backup:
Set up RDS PostgreSQL with weekly backups, retaining them for 4 weeks.
Bonus Requirement:
Utilize AWS CloudTrail to monitor and alert on unauthorized access attempts.

# Getting Started
To deploy the infrastructure and set up the CI/CD pipeline, follow these steps:

Clone this repository to your local machine.

Ensure you have Terraform and AWS CLI installed and configured with appropriate access credentials.

Navigate to the terraform directory.

Run terraform init to initialize the Terraform configuration.

Run terraform apply to create the infrastructure.

Follow the prompts to confirm the changes.

Once the infrastructure is deployed, follow the instructions in the infrastructure runbook for operational procedures.

# Infrastructure Runbook
Refer to the runbook.md file in this repository for operational procedures and guidelines on managing the online learning platform infrastructure.