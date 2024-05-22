# Define variables for project, region, and other configurable parameters
variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
}

variable "network" {
  description = "VPC network name"
  type        = string
  default     = "default"
}

variable "prefix_length" {
  description = "Prefix length for the reserved IP address range"
  type        = number
  default     = 16
}

variable "initial_user" {
  description = "Initial AlloyDB user name"
  type        = string
  default     = "alloydb-user"
}

variable "initial_password" {
  description = "Initial AlloyDB user password"
  type        = string
  sensitive   = true
}

variable "cpu_count" {
  description = "Number of CPUs for the AlloyDB instance"
  type        = number
  default     = 2
}
