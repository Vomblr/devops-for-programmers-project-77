resource "yandex_compute_instance" "web1" {
  name        = "web1"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"

  resources {
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80o2eikcn22b229tsa" # Ubuntu 20.04 LTS with docker
      size     = 30
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.hexlet-subnet-b.id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.yandex_user}:${file(var.public_ssh_key_path)}"
  }
}

resource "yandex_compute_instance" "web2" {
  name        = "web2"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"

  resources {
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80o2eikcn22b229tsa" # Ubuntu 20.04 LTS with docker
      size     = 30
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.hexlet-subnet-b.id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.yandex_user}:${file(var.public_ssh_key_path)}"
  }
}
