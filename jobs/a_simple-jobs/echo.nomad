job "echo" {
  datacenters = [ "dc1" ]
  type = "service"

  group "app" {
    count = 2

    network {
      port "http" {
        to = 8080
      }
    }

    service {
      name = "echo"
      tags = [ "app" ]
      port = "http"

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

    task "server" {
      driver = "docker"

      config {
        image = "jmalloc/echo-server"
        ports = [ "http" ]
      }
    }
  }
}