job "http-echo" {
  datacenters = ["dc1"]
  type = "service"

  group "echo-app" {
    count = 5

    # https://developer.hashicorp.com/nomad/docs/job-specification/update
    update {
      canary = 1
      max_parallel = 2
      auto_revert = true
      auto_promote = true

      health_check = "checks"
      min_healthy_time = "10s"
      healthy_deadline = "3m"
      progress_deadline = "5m"
    }

    network {
      port "http" {}
    }

    service {
      name = "echo"
      port = "http"
      tags = [
        "app",
        "urlprefix-/http-echo",
      ]

      check {
        type     = "http"
        path     = "/health"
        interval = "2s"
        timeout  = "2s"
      }
    }

    task "echo-server" {
      driver = "docker"
      config {
        image = "hashicorp/http-echo:latest"
        args = [
          "-listen", ":${NOMAD_PORT_http}",
          "-text", "Hey! This is echo update from ${NOMAD_IP_http}:${NOMAD_PORT_http}.",
        ]
        ports = ["http"]
      }
    }
  }
}