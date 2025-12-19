resource "google_compute_instance_template" "tpl" {
  name_prefix  = "tp-template"
  machine_type = "e2-micro"

  disk {
    source_image = "debian-cloud/debian-12"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {}
  }

  metadata_startup_script = file("scripts/startup.sh")
}

resource "google_compute_region_instance_group_manager" "mig" {
  name   = "tp-mig"
  region = var.region

  version {
    instance_template = google_compute_instance_template.tpl.id
  }

  target_size = 2
}

resource "google_compute_autoscaler" "autoscaler" {
  name   = "tp-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.mig.id

  autoscaling_policy {
    max_replicas = 3
    min_replicas = 1
    cpu_utilization {
      target = 0.6
    }
  }
}
