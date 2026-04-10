# Automated Infrastructure Deployment using Shell Scripting + Cron Jobs

This project demonstrates an automated system to deploy and manage cloud infrastructure using **Shell Scripting**, **Terraform**, and **Cron Jobs**. It focuses on reducing manual effort, improving consistency, and enabling scheduled infrastructure operations.

---

## Features

- **Infrastructure Automation**
  - Automated cloud infrastructure provisioning using Terraform.
  - Shell scripts created to execute Terraform commands.

- **Task Scheduling**
  - Configured Cron Jobs to run scripts at defined intervals.
  - Enabled automated infrastructure updates and maintenance.

- **Logging & Monitoring**
  - Implemented logging mechanisms to track execution results.
  - Simplified debugging and troubleshooting of failures.

- **Efficient Deployment**
  - Reduced manual intervention in infrastructure management.
  - Improved consistency and reliability of deployments.

---

## Technologies Used

- **Linux** – Operating system for scripting and execution  
- **Shell Scripting** – Automation scripts  
- **Cron Jobs** – Task scheduling  
- **Terraform** – Infrastructure as Code (IaC)  
- **AWS** – Cloud platform for deployment  

---

## Project Structure

├── scripts/
│ └── deploy.sh # Shell script to automate Terraform execution
├── terraform/
│ ├── main.tf # Terraform configuration file
│ ├── variables.tf # Input variables
│ └── outputs.tf # Output definitions
├── logs/
│ └── execution.log # Log file for script execution
└── README.md # Project documentation


---

## Prerequisites

- Linux environment (Ubuntu recommended)
- AWS account with configured credentials
- Terraform installed
- Basic knowledge of shell scripting

---

## Setup & Usage

### 1. Clone Repository
```bash
git clone <your-repo-url>
cd <your-repo-folder>
