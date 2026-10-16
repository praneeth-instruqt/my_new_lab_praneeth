resource "lab" "main" {
  title       = "Deploy your first app to Cloud Run"
  description = <<-EOF
  Build a small Python web app, run it locally, and deploy it to Google Cloud Run
  from source. Then ship a change and watch Cloud Run roll out a new revision.
  EOF

  # timelimit and idle are both required on every lab.
  settings {
    theme = "modern-dark"

    timelimit {
      duration   = "1h"
      show_timer = true
    }

    idle {
      enabled = true
      timeout = "15m"
    }
  }

  layout = resource.layout.workstation

  content {
    title = "Cloud Run"

    chapter "setup" {
      title = "Get set up"

      page "configure" {
        reference = resource.page.configure
      }
    }

    chapter "build" {
      title = "Build the app"

      page "run_locally" {
        reference = resource.page.run_locally
      }
    }

    chapter "deploy" {
      title = "Deploy to Cloud Run"

      page "deploy" {
        reference = resource.page.deploy
      }

      page "update" {
        reference = resource.page.update
      }
    }
  }
}
