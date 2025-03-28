resource "google_compute_instance" "dns_root" {
  name         = "${local.prefix}-dns-root"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.dns_subnet.self_link
    network_ip = "10.0.0.2"
  }
}

resource "google_compute_instance" "dns_apps" {
  name         = "${local.prefix}-dns-apps"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.dns_subnet.self_link
    network_ip = "10.0.0.3"
  }
}

resource "google_compute_instance" "dns_infra" {
  name         = "${local.prefix}-dns-infra"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.dns_subnet.self_link
    network_ip = "10.0.0.4"
  }
}

resource "google_compute_instance" "app_vm1" {
  name         = "${local.prefix}-app-vm1"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.app_subnet.self_link
    network_ip = "10.0.10.2"
  }
}

resource "google_compute_instance" "app_vm2" {
  name         = "${local.prefix}-app-vm2"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.app_subnet.self_link
    network_ip = "10.0.10.3"
  }
}


resource "google_compute_instance" "infra_vm1" {
  name         = "${local.prefix}-infra-vm1"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.infra_subnet.self_link
    network_ip = "10.0.20.2"
  }
}

resource "google_compute_instance" "infra_vm2" {
  name         = "${local.prefix}-infra-vm2"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.infra_subnet.self_link
    network_ip = "10.0.20.3"
  }
}
