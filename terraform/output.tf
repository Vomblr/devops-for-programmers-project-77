output "webservers" {
  value = [
    yandex_compute_instance.web1,
    yandex_compute_instance.web2
  ]
}

output "mysql_host" {
  value = one(yandex_mdb_mysql_cluster.hexlet-cluster.host).fqdn
}
