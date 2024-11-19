  provider "google" {
    
    project = "buzzwatch-422510"
    region  = "europe-west1-d"
  }

  resource "google_compute_firewall" "allow_port_80" {
    name    = "allow-port-80"
    network = "default"

    allow {
      protocol = "tcp"
      ports    = ["80"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["http-server", "https-server"]  
  }

  resource "google_compute_firewall" "allow_port_8000" {
    name    = "allow-port-8000"
    network = "default"

    allow {
      protocol = "tcp"
      ports    = ["8000"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["http-server", "https-server"]  
  }

  resource "google_compute_instance" "default" {
    name         = "test-omgeving"
    machine_type = "e2-medium"
    zone         = "europe-west1-d"

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-11"
      }
    }

    network_interface {
      network = "default"
      access_config {
      }
    }

    metadata_startup_script = file("startup.sh")

    tags = ["http-server", "https-server"]

    service_account {
      email  = "docker-image@buzzwatch-422510.iam.gserviceaccount.com"
      scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    }
  }