resource "google_compute_firewall" "default" {
  name    = "jenkins-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "22"]
  }

  source_tags = ["web"]
}

resource "google_compute_network" "default" {
  name = "jenkins-network"
}

resource "google_compute_instance" "default" {
  name         = "jenkins-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["http", "https"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
#   scratch_disk {
#     interface = "SCSI"
#   }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    enableoslogin: true
  }


  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "terraform-key@nimble-album-369317.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}