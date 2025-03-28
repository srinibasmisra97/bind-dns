resource "google_compute_network" "vpc" {
  name                    = "${local.prefix}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "dns_subnet" {
  name          = "${google_compute_network.vpc.name}-dns-sbn"
  network       = google_compute_network.vpc.self_link
  ip_cidr_range = "10.0.0.0/24"
}

resource "google_compute_subnetwork" "app_subnet" {
  name          = "${google_compute_network.vpc.name}-app-sbn"
  network       = google_compute_network.vpc.self_link
  ip_cidr_range = "10.0.10.0/24"
}

resource "google_compute_subnetwork" "infra_subnet" {
  name          = "${google_compute_network.vpc.name}-infra-sbn"
  network       = google_compute_network.vpc.self_link
  ip_cidr_range = "10.0.20.0/24"
}

resource "google_compute_firewall" "allow-iap" {
  name          = "${google_compute_network.vpc.name}-allow-iap"
  network       = google_compute_network.vpc.self_link
  source_ranges = ["35.235.240.0/20"]
  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }
}

resource "google_compute_firewall" "allow-internal" {
  name          = "${google_compute_network.vpc.name}-allow-internal"
  network       = google_compute_network.vpc.self_link
  source_ranges = ["10.0.0.0/24","10.0.10.0/24","10.0.20.0/24"]
  allow {
    protocol = "all"
  }
}

resource "google_compute_router" "router" {
  name    = "${google_compute_network.vpc.name}-router"
  network = google_compute_network.vpc.self_link
}

resource "google_compute_router_nat" "nat" {
  name                               = "${google_compute_network.vpc.name}-nat"
  router                             = google_compute_router.router.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"
}
