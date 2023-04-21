terraform {
  required_version = ">= 0.13"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
	  version = "0.89.0"
    }

    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.20.0"
    }
  }
}

provider "yandex" {
  zone = "ru-central1-b"
  service_account_key_file=var.service_account_key_file_path
  folder_id=var.yandex_folder_id
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = "https://api.datadoghq.eu/"
}
