job "http-echo" {
  datacenters = ["dc1"]
  type = "service"

  group "echo-app" {
    count = 5

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
          "-text", "Hey! Hello from ${NOMAD_IP_http}:${NOMAD_PORT_http}.",
        ]
        ports = ["http"]
      }
    }
  }
}