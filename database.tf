resource "google_sql_database_instance" "mysql" {
  name             = "tp-mysql"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "db" {
  name     = "company"
  instance = google_sql_database_instance.mysql.name
}

resource "google_sql_user" "user" {
  name     = "user"
  password = "password"
  instance = google_sql_database_instance.mysql.name
}
