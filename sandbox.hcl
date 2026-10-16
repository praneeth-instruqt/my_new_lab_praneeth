resource "network" "main" {
  subnet = "10.0.5.0/24"
}

# A fresh GCP project per learner.
resource "google_project" "cloudrun_lab" {
  regions = ["us-central1"]

  services = [
    "run.googleapis.com",
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com",
    "storage.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "logging.googleapis.com",
  ]

  labels = {
    purpose = "lab"
  }

  # Used by the learner to sign in to the GCP console.
  user "student" {
    roles = ["roles/editor", "roles/run.admin"]
  }

  # Used by gcloud inside the workstation. Owner so the setup script can grant
  # Cloud Build the roles it needs for `gcloud run deploy --source`.
  service_account "workstation" {
    roles = ["roles/owner"]
  }
}

resource "template" "service_account_key" {
  source      = resource.google_project.cloudrun_lab.service_account.0.key
  destination = "./service-account.json"
}

resource "copy" "app" {
  source      = "./files/app/"
  destination = "./container-data/app/"
  permissions = "0644"
}

resource "container" "workstation" {
  image {
    name = "gcr.io/google.com/cloudsdktool/google-cloud-cli:slim"
  }

  command = ["tail", "-f", "/dev/null"]

  environment = {
    GOOGLE_CLOUD_PROJECT           = resource.google_project.cloudrun_lab.project_id
    GOOGLE_APPLICATION_CREDENTIALS = "/etc/gcp/service-account.json"
    CLOUDSDK_CORE_PROJECT          = resource.google_project.cloudrun_lab.project_id
    REGION                         = "us-central1"
  }

  resources {
    cpu    = 1000
    memory = 1024
  }

  network {
    id = resource.network.main.meta.id
  }

  port {
    local = 8080
  }

  volume {
    source      = resource.template.service_account_key.destination
    destination = "/etc/gcp/service-account.json"
    type        = "bind"
    read_only   = true
  }

  volume {
    source      = resource.copy.app.destination
    destination = "/root/app"
    type        = "bind"
  }
}

# Authenticates gcloud, installs Flask for local runs, and grants Cloud Build
# the roles it needs to build and push the image.
resource "exec" "workstation_setup" {
  script  = "scripts/setup/workstation.sh"
  timeout = "600s"
  target  = resource.container.workstation

  environment = {
    PROJECT_ID = resource.google_project.cloudrun_lab.project_id
  }
}
