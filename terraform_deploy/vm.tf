resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  auto_create_subnetworks = true
}

resource "google_compute_address" "webserver1-static-address" {
  name = "webserver1-static-ip"
}

resource "google_compute_address" "webserver2-static-address" {
  name = "webserver2-static-ip"
}

resource "google_compute_instance" "sql-server" {
  name         = "sql-server"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"

  tags = ["sql-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10-buster-v20210512"
      size = 10
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
    }
  }

  metadata = {
      ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}

resource "google_compute_instance" "webserver1" {
  name         = "webserver1"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"

  tags = ["webserver1"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10-buster-v20210512"
      size = 10
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      nat_ip = "${google_compute_address.webserver1-static-address.address}"
    }
  }

  metadata = {
      ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}

resource "google_compute_instance" "webserver2" {
  name         = "webserver2"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"

  tags = ["webserver2"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10-buster-v20210512"
      size = 10
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      nat_ip = "${google_compute_address.webserver2-static-address.address}"
    }
  }

  metadata = {
      ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}


resource "google_compute_instance_group" "webservers" {
  name        = "webservers"

  instances = [
    google_compute_instance.webserver1.id,
    google_compute_instance.webserver2.id,
  ]

  named_port {
    name = "http"
    port = "8080"
  }

  named_port {
    name = "https"
    port = "8443"
  }
}

resource "google_compute_firewall" "ssh-rule" {
  name = "ssh"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  target_tags = ["webserver1", "webserver2", "sql-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "mysql-rule" {
  name = "sql"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports = ["3306"]
  }
  target_tags = ["sql-server"]
  source_tags = ["webserver1", "webserver2"]
}

resource "google_compute_firewall" "web-rule" {
  name = "http"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports = ["80"]
  }
  target_tags = ["webserver1", "webserver2"]
  source_ranges = ["0.0.0.0/0"]
}
