# 🔒 Secure Terraform State with AWS (S3, DynamoDB & Replication)

This project provides a secure and highly available solution for managing Terraform state files using AWS S3, DynamoDB, and replication mechanisms. It ensures state integrity, availability, and security by implementing best practices such as state locking, versioning, encryption, and cross-region replication.

Additionally, the project includes an EC2 instance deployment to validate the infrastructure setup, demonstrating how Terraform can be used effectively in a production environment.

---

## 📁 Folder Structure
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

---

## 🔒 Features
✅ **Terraform State Management**: Uses an S3 bucket as a backend for storing Terraform state.  
✅ **State Locking**: DynamoDB is configured to lock the state file and prevent conflicts.  
✅ **Replication**: The Terraform state file is replicated across AWS regions for redundancy.  
✅ **IAM Role & Policy**: Secure access control using IAM roles and policies.  
✅ **Backup Strategy**: Implements backup mechanisms to restore the state file in case of failure.  

---

## 🛠 Getting Started
Follow these steps to deploy the setup in your AWS account.

### 🔹 **Prerequisites**
1️⃣ Install **Terraform** (≥ v1.0) → [Download Terraform](https://developer.hashicorp.com/terraform/downloads)  
2️⃣ Configure **AWS CLI** → [AWS CLI Setup](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)  
3️⃣ Set up your **AWS credentials** (`~/.aws/credentials`)  

---

## 🔧 Usage

### 1️⃣ **Clone the Repository**
```bash
git clone https://github.com/clovisbernard/statefile-secure.git
cd statefile-secure
```

### 2️⃣ **Navigate to the `s3-bucket/` directory and initialize Terraform**
```bash
cd s3-bucket
terraform init
```
This will download the necessary providers and set up the backend.

### 3️⃣ **Apply the configuration to create the S3 bucket, IAM role, and DynamoDB**
```bash
terraform plan
terraform apply
```

### 4️⃣ **Navigate to the `ec2-instance/` directory and initialize Terraform**
```bash
cd ../ec2-instance
terraform init
```

### 5️⃣ **Apply the configuration to create the EC2 instance**
```bash
terraform plan
terraform apply
```

---

## 📌 Verifying Replication
- Check the S3 bucket in the AWS Console to confirm replication status.
- Delete the statefile in `us-east-1` and verify if it's still backup in `us-east-2`.
- Verify the DynamoDB table for state locking.
- Use the AWS CLI to list objects in the replicated bucket:
```bash
aws s3 ls s3://your-replicated-bucket-name --region us-east-2
```
- Review the changes and confirm with `yes` when prompted.

---

## 🔒 Verify State Locking
- **Open two terminals and run `terraform apply` simultaneously.**
- **The second one should fail due to the DynamoDB lock.**

---

## 📜 Notes on Statefile Locking with S3 Bucket
- Not all backends support state locking. AWS S3 **supports state locking**.
- State locking happens **automatically** on all operations that could write state.
- If Terraform fails, **it will not continue** until the lock is released.
- You can disable state locking for some commands with the `-lock` flag (not recommended).
- If acquiring the lock takes longer than expected, Terraform will output a status message.
- If Terraform doesn’t output a message, state locking is still occurring if your backend supports it.
- Terraform has a `force-unlock` command to manually unlock the state if unlocking fails:

---

## 🔎 Additional Security Enhancements

While this project covers the essentials of securing a Terraform state file, there are additional best practices you may explore:
- State Encryption: Enable S3 server-side encryption (SSE-KMS) to encrypt the Terraform state file at rest.
- Automated Backups: Configure AWS Backup to automate state file backups.
- Logging & Monitoring: Enable AWS CloudTrail and S3 access logs to monitor state file activity.

These additional measures can further enhance the security, reliability, and recoverability of your Terraform state.

