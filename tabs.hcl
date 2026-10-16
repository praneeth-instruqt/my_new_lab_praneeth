resource "terminal" "shell" {
  target            = resource.container.workstation
  shell             = "/bin/bash"
  working_directory = "/root/app"
}

resource "service" "app" {
  target = resource.container.workstation
  scheme = "http"
  port   = 8080
}

# The GCP console blocks iframes, so it opens in a new window.
resource "external_website" "cloud_run_console" {
  url                = "https://console.cloud.google.com/run?project=${resource.google_project.cloudrun_lab.project_id}"
  open_in_new_window = true
}

resource "cloud_credentials" "gcp" {
  google_project {
    target = resource.google_project.cloudrun_lab
    users  = ["student"]
  }
}
