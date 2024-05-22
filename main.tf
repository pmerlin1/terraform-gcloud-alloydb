provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# Create a global internal IP address for VPC peering
resource "google_compute_global_address" "private_ip_address_alloydb" {
  name          = "cloudsql-addr-space-alloydb"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  project       = var.project_id
  network       = var.network
  prefix_length = var.prefix_length
}

# Establish a VPC peering connection
resource "google_service_networking_connection" "private_vpc_connection_alloydb" {
  network                  = "projects/${var.project_id}/global/networks/${var.network}"
  service                  = "servicenetworking.googleapis.com"
  reserved_peering_ranges  = [google_compute_global_address.private_ip_address_alloydb.name]
}

# Create an AlloyDB cluster
resource "google_alloydb_cluster" "alloydb_cluster" {
  cluster_id = "alloydb-chatbot-cluster"
  location   = var.region
  project    = var.project_id
  network    = var.network
  
  continuous_backup_config {
    enabled = false
  }

  initial_user {
    user     = var.initial_user
    password = var.initial_password  # Use a secure method to manage secrets
  }
}

# Create an AlloyDB instance
resource "google_alloydb_instance" "alloydb_instance" {
  cluster        = google_alloydb_cluster.alloydb_cluster.id
  instance_id    = "instance-1"
  instance_type  = "PRIMARY"

  machine_config {
    cpu_count = var.cpu_count
  }
}

# Output the AlloyDB instance connection details
output "alloydb_instance_connection" {
  description = "AlloyDB instance connection details"
  value = {
    project_id  = var.project_id
    region      = var.region
    cluster_id  = google_alloydb_cluster.alloydb_cluster.cluster_id
    instance_id = google_alloydb_instance.alloydb_instance.instance_id
  }
}
