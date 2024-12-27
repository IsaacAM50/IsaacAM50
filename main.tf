terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.14.1"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = file("cred.json")
  project = "isaackeepcoding"

}

resource "google_compute_network" "red_local"{
    name = "nueva-red"
}

resource "google_compute_instance" "mi_maquina"{
    depends_on = [google_compute_network.red_local]
    name = "mi-maquina"
    machine_type = "e2-medium"
    zone = "europe-west3-a"
    boot_disk {
      initialize_params {
        image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-arm64-v20241219"
      }
    }
    network_interface {
      network = google_compute_network.red_local.name
    }
}

resource "google_storage_bucket" "bucket" {
  name          = "mi-bucket-almacenamiento-223322"
  location      = "EU"
  force_destroy = true
}