resource "lab" "main" {
  title       = "my_new_lab_praneeth_change_3"
  description = <<-EOF
  This is the Skeleton Lab.
  You can use this as a minimal starting point for developing labs.
  EOF

  # timelimit and idle are both required on every lab.
  settings {
    theme = "modern-dark"

    timelimit {
      duration = "1h"
    }

    idle {
      enabled = true
      timeout = "15m"
    }
  }

  layout = resource.layout.single_panel
}
