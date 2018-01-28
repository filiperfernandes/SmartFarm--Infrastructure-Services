resource "google_compute_firewall" "frontend_rules" {
  name    = "default"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["lbal", "nagios"]
}


# create the frontend lbal
resource "google_compute_instance" "lbal" {
    name = "lbal"
    machine_type = "${var.GCP_MACHINE_TYPE}"
    zone = "${var.GCP_REGION}"

    boot_disk {
        initialize_params {
        # image list can be found at:
        # https://cloud.google.com/compute/docs/images
        image = "ubuntu-os-cloud/ubuntu-1604-lts"
        }
    }

    network_interface {
        network = "default"
        access_config {
        }
    }
  tags = ["lbal"]
}



output "lbal" {
    value = "${join(" ", google_compute_instance.lbal.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

# create the frontend nagios
resource "google_compute_instance" "nagios" {
    name = "nagios"
    machine_type = "${var.GCP_MACHINE_TYPE}"
    zone = "${var.GCP_REGION}"

    boot_disk {
        initialize_params {
        # image list can be found at:
        # https://cloud.google.com/compute/docs/images
        image = "ubuntu-os-cloud/ubuntu-1604-lts"
        }
    }

    network_interface {
        network = "default"
        access_config {
        }
    }
  tags = ["nagios"]
}



output "nagios" {
    value = "${join(" ", google_compute_instance.nagios.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}