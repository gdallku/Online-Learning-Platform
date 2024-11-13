## Online Learning Platform Requirements

### Objective
Construct a scalable, secure infrastructure for an online learning platform.

### Methodology
This Assignment should be organized in the following 4 phases:
- *Design:* Prepare and confirm the design.
- *Build and Deploy:* Write Infrastructure as Code (IaC) and deploy using the AWS CI/CD pipeline.
- *Document:*
  - Provide a `Readme.md` file explaining how to create the infrastructure and run the CI/CD pipeline.
  - Provide an infrastructure runbook in Markdown Format detailing operational procedures.
- *Demo:* Prepare a small demo script on how you are going to explain your work. Provide a video recording showcasing the deployment and operation of the infrastructure.

**All assignment assests should be stored in github repository.**

### General Requirements
1. Map out the system architecture using draw.io.
2. Generate an IAM user with the necessary permissions for this specific infrastructure.
3. Implement an AWS CI/CD pipeline for continuous update deployment.
4. Construct Terraform code that follows the AWS Well-Architected Framework, focusing on scalability and security. Organize terraform resources in modules. 
5. Create a Bastion server to access DB Server

### AWS Resources
- VPC
- S3 (for course materials and videos)
- EC2 (t2.micro for application servers)
- RDS (Postgresql engine for student data)
- DynamoDB (for course progress tracking)
- EFS (for shared resources among students)
- CloudWatch
- Autoscaling Group
- Load Balancer (Application Load Balancer)

### Specific Technical Requirements

#### Security
- Security Group for RDS instances to restrict access, allowing only specific ports.
- NACLs with custom rules for different subnets.

#### Autoscaling
- Minimum 1 instances, scale up to 2  based on CPU and memory usage.

#### Monitoring & Log Retention
- CloudWatch for system and application logs with 2 days retention.
- Enable RDS performance insights.

#### Database Backup
- RDS Postgresql with weekly backups, retaining for 4 weeks.

#### Bonus Requirement
- Use AWS CloudTrail to monitor and alert on unauthorized access attempts.
