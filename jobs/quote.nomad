job "quote" {
  datacenters = [ "dc1" ]
  type = "service"

  group "app" {
    count = 3

    network {
      port "http" {
        to = 8080
      }
    }

    service {
      name = "quote"
      tags = [ "app" ]
      port = "http"

      meta {
        nomad_ingress_enabled = true
        nomad_ingress_hostname = "quote"
        nomad_ingress_path = "/"
        nomad_ingress_port = "http"
      }

      check {
        name = "alive"
        type = "http"
        path = "/"
        interval = "10s"
        timeout = "2s"
      }
    }

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    task "backend" {
      driver = "docker"

      config {
        image = "docker.io/datawire/quote:0.4.1"
        ports = [ "http" ]
      }
    }
  }
}