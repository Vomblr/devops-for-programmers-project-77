resource "yandex_vpc_network" "hexlet-network" {
  name = "hexlet-network"
}

resource "yandex_vpc_subnet" "hexlet-subnet-b" {
  name           = "hexlet-subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.hexlet-network.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}
