resource "google_compute_global_address" "lb_ip" {
  name = "tp-lb-ip"
}

resource "google_compute_health_check" "hc" {
  name = "tp-hc"
  http_health_check {
    port = 80
  }
}
