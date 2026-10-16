resource "task" "configure" {
  description     = "Point gcloud at your lab project and region"
  success_message = "gcloud is configured."

  config {
    target            = resource.container.workstation
    working_directory = "/root/app"
  }

  condition "project_and_region" {
    description = "gcloud uses your lab project and the us-central1 region for Cloud Run"

    check {
      script          = "scripts/configure/check.sh"
      failure_message = "Set the project with `gcloud config set project $GOOGLE_CLOUD_PROJECT` and the region with `gcloud config set run/region us-central1`."
    }

    solve {
      script = "scripts/configure/solve.sh"
    }
  }
}

resource "task" "run_locally" {
  description     = "Run the app locally on port 8080"
  success_message = "Your app is running locally."

  config {
    target            = resource.container.workstation
    working_directory = "/root/app"
  }

  condition "app_responds" {
    description = "The app responds on http://localhost:8080"

    check {
      script          = "scripts/run_locally/check.sh"
      failure_message = "Nothing answered on port 8080. Start the app with `python3 main.py` and keep it running."
    }

    solve {
      script = "scripts/run_locally/solve.sh"
    }
  }
}

resource "task" "deploy" {
  description     = "Deploy the app to Cloud Run"
  success_message = "Your app is live on Cloud Run."

  config {
    target            = resource.container.workstation
    working_directory = "/root/app"
    timeout           = "60s"
  }

  condition "service_live" {
    description = "A public Cloud Run service named hello returns HTTP 200"

    config {
      timeout = "900s"
    }

    check {
      script          = "scripts/deploy/check.sh"
      failure_message = "The hello service was not found or did not return HTTP 200. Did you deploy with --allow-unauthenticated?"
    }

    solve {
      script = "scripts/deploy/solve.sh"
    }
  }
}

resource "task" "update" {
  description     = "Ship a change as a new revision"
  success_message = "Cloud Run rolled out your new revision."

  config {
    target            = resource.container.workstation
    working_directory = "/root/app"
    timeout           = "60s"
  }

  condition "new_revision" {
    description = "The hello service has at least two revisions and serves your new message"

    config {
      timeout = "900s"
    }

    check {
      script          = "scripts/update/check.sh"
      failure_message = "The hello service needs a second revision whose MESSAGE is different from the default."
    }

    solve {
      script = "scripts/update/solve.sh"
    }
  }
}
