job "fabio" {
  datacenters = ["dc1"]
  type = "system"

  group "fabio" {
    count = 1

    network {
      port "proxy" {
        to = 9999
      }
      port "consul" {
        to = 9998
      }
    }

    task "fabio" {
      driver = "raw_exec"

      config {
        command = "fabio"
        args    = [
          "-proxy.strategy=rr",
          "-proxy.addr=${NOMAD_IP_proxy}:${NOMAD_PORT_proxy}",
          "-registry.consul.register.addr=${NOMAD_IP_consul}:${NOMAD_PORT_consul}"
        ]
      }

      artifact {
        source      = "https://github.com/fabiolb/fabio/releases/download/v1.6.3/fabio-1.6.3-linux_amd64"
        destination = "local/fabio"
        mode        = "file"
      }
    }
  }
}
