resource "yandex_mdb_mysql_cluster" "hexlet-cluster" {
  name        = "hexlet-cluster"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.hexlet-network.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 10
  }

  mysql_config = {
    sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    max_connections               = 100
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    innodb_print_all_deadlocks    = true

  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.hexlet-subnet-b.id
  }
}

resource "yandex_mdb_mysql_database" "hexlet-db" {
  cluster_id = yandex_mdb_mysql_cluster.hexlet-cluster.id
  name       = var.mysql_database
}

resource "yandex_mdb_mysql_user" "hexlet-user" {
    cluster_id = yandex_mdb_mysql_cluster.hexlet-cluster.id
    name       = var.mysql_user
    password   = var.mysql_password

    permission {
      database_name = var.mysql_database
      roles         = ["ALL"]
    }
}
