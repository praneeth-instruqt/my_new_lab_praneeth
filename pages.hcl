resource "page" "configure" {
  title = "Configure gcloud"
  file  = "instructions/setup/configure.md"

  activities = {
    configure = resource.task.configure
  }
}

resource "page" "run_locally" {
  title = "Run the app locally"
  file  = "instructions/build/run_locally.md"

  activities = {
    run_locally = resource.task.run_locally
  }
}

resource "page" "deploy" {
  title = "Deploy from source"
  file  = "instructions/deploy/deploy.md"

  activities = {
    deploy = resource.task.deploy
  }
}

resource "page" "update" {
  title = "Ship a new revision"
  file  = "instructions/deploy/update.md"

  activities = {
    update = resource.task.update
  }
}
