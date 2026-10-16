resource "layout" "workstation" {
  column {
    width = "35"

    instructions {}
  }

  column {
    width = "65"

    tab "terminal" {
      title  = "Terminal"
      target = resource.terminal.shell
      active = true
    }

    tab "app" {
      title  = "App (localhost:8080)"
      target = resource.service.app
    }

    tab "console" {
      title  = "GCP Console"
      target = resource.external_website.cloud_run_console
    }

    tab "credentials" {
      title  = "GCP Credentials"
      target = resource.cloud_credentials.gcp
    }
  }
}
