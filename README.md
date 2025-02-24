# 🔒 Secure Terraform State with AWS (S3, DynamoDB & Replication)

This project demonstrates how to securely store and replicate Terraform state files using an Amazon S3 bucket with IAM roles and policies. It also includes an EC2 instance creation to test the infrastructure setup.

## Folder Structure
```bash
statefile-secure/
├── README.md                        # Project documentation
├── ec2-instance/                    # Terraform configuration for EC2 instance
│   ├── backend.tf                   # Backend configuration for Terraform state
│   ├── main.tf                      # EC2 instance resource definition
│   ├── providers.tf                 # Provider configuration
│   ├── variables.tf                 # Variable definitions
├── s3-bucket/                       # Terraform configuration for S3 and IAM
│   ├── main.tf                      # S3 bucket and replication setup
│   ├── role-policy-attachement.tf   # IAM role and policy configuration
│   ├── providers.tf                 # AWS provider configuration
│   ├── terraform.tfstate            # Terraform state file
│   ├── terraform.tfstate.backup     # Backup of the Terraform state file
│   ├── variables.tf                 # Variables for bucket configuration
```

## Features
 ✅ Terraform State Management: Uses an S3 bucket as a backend for storing Terraform state.
 ✅ State Locking: DynamoDB is configured to lock the state file and prevent conflicts.
 ✅ Replication: The Terraform state file is replicated across AWS regions for redundancy.
 ✅ IAM Role & Policy: Secure access control using IAM roles and policies.
 ✅ Backup Strategy: Implements backup mechanisms to restore the state file in case of failure.


## Getting Started
Follow these steps to deploy the setup in your AWS account.

###  **Prerequisites**
1️⃣ Install **Terraform** (≥ v1.0) → [Download Terraform](https://developer.hashicorp.com/terraform/downloads)  
2️⃣ Configure **AWS CLI** → [AWS CLI Setup](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)  
3️⃣ Set up your **AWS credentials** (`~/.aws/credentials`)  

---

## 🔧 **Usage**

### 1️ **Clone the Repository**
```bash
git clone https://github.com/clovisbernard/statefile-secure.git
cd terraform-secure-state
```
### 2️ **Navigate to the s3-bucket/ directory and initialize Terraform:**
```bash
cd s3-bucket
terraform init
```
This will download the necessary providers and set up the backend.
### 3️ **Apply the configuration to create the S3 bucket, IAM role, and DynamoDB:**
```bash
terraform plan
terraform apply
```
### 4 **Navigate to the ec2-instance/ directory and initialize Terraform:**
```bash
cd ../ec2-instance
terraform init
```
### 5 **Apply the configuration to create the EC2 instance:**
```bash
terraform plan
terraform apply
```

### **Verifying Replication**

 - Check the S3 bucket in the AWS Console to confirm replication status.
 - Delete the statefile in us-east-1 and verify if it's replicated in us-east-2.
 - Verify the DynamoDB table for state locking.
 - Use the AWS CLI to list objects in the replicated bucket:
 - Review the changes and confirm with yes when prompted.

### **Verify State Locking**
- **Open two terminals and run terraform apply simultaneously.**
- **The second one should fail due to the DynamoDB lock.**
----

### **Notes about statefile locking with s3 bucket
Not all backends support state locking. AWS S3 supports state locking
State locking happens automatically on all operations that could write state
If terraform fails, terraform will not continue
You can disable state locking for some commands with the flag -lock flag but it is not recommanded
If acquiring the lock is taking longer than expected, terraform will ouput a status message
If Terraform doesn't output a message, state locking os still occuring if your beckend support it
Terraform has a force-unlock command to manually unlock the state if unlocking fail# statefile-secure
# statefile-secure
# statefile-secure
