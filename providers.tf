terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.42.0"
    }
  }
}

provider "google" {
  project = "nimble-album-369317"
  credentials = file("C:/Users/Jason/Downloads/terraform-gcp-key.json")
}