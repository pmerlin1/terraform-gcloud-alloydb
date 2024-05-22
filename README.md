# terraform-gcloud-alloydb
Quick example of creating AlloyDB with Terraform

## Overview
This repository provides a quick example of how to create an AlloyDB cluster on Google Cloud using Terraform. This configuration sets up a high-availability (HA) multi-zone AlloyDB cluster with a primary instance.

## Configuration Details
- **CPU Count**: The default configuration includes 2 vCPUs and 16GB of RAM.
- **High-Availability**: This setup is configured for high availability across multiple zones.
- **Estimated Cost**: As of late May 2024, the estimated cost for this setup is approximately $458.31 per month, assuming 10GB of storage.

## Prerequisites
Before you begin, ensure you have the following:
- A Google Cloud project with billing enabled
- Terraform installed on your local machine
- Appropriate IAM permissions to create and manage AlloyDB resources

## Variables
The following variables can be configured in the `variables.tf` file or via the command line:

- `project_id`: Google Cloud project ID
- `region`: Google Cloud region
- `network`: VPC network name (default: `default`)
- `prefix_length`: Prefix length for the reserved IP address range (default: 16)
- `initial_user`: Initial AlloyDB user name (default: `alloydb-user`)
- `initial_password`: Initial AlloyDB user password (sensitive)
- `cpu_count`: Number of CPUs for the AlloyDB instance (default: 2)

## Usage

1. **Clone the repository:**
    ```bash
    git clone https://github.com/pmerlin1/terraform-gcloud-alloydb
    cd terraform-gcloud-alloydb
    ```

2. **Initialize Terraform:**
    ```bash
    terraform init
    ```

3. **Create a `terraform.tfvars` file with your variable values:**
    ```hcl
    project_id     = "your-project-id"
    region         = "your-region"
    initial_password = "your-secure-password"
    ```

4. **Apply the Terraform configuration:**
    ```bash
    terraform apply
    ```
   Review the plan and confirm with `yes` to create the resources.

## Outputs
After applying the configuration, the connection details for the AlloyDB instance will be outputted. These details include the project ID, region, cluster ID, and instance ID.

## Notes
- This example is intended for demonstration purposes. Adjust resource configurations according to your production requirements.
- Ensure you manage sensitive data like passwords securely by using secret management tools, such as Google Secret Manager or GitHub Actions Secrets.

## Cleanup
To avoid incurring charges, you can destroy the resources created by this Terraform configuration:
```bash
terraform destroy
