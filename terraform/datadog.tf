resource "datadog_monitor" "lb_5xx_errors" {
  name    = "High number of 5xx errors"
  type    = "metric alert"
  message = "High number of 5xx errors detected for Load Balancer my-lb"
  query   = "sum(last_5m):aws.elb.httpcode_elb_5xx_count{loadbalancer:my-lb} >= 10"

  monitor_thresholds {
    critical = 10
  }
}

resource "datadog_monitor" "http_check" {
  name           = "App Health Check"
  type           = "metric alert"
  message        = "Приложение недоступно!"
  tags           = ["env:production"]
  notify_no_data = false

  query = "avg(last_5m):avg:network.http.can_connect{*} by {host} <= 0"

  monitor_thresholds {
    ok                = 1
    warning           = 0.4
    warning_recovery  = 0.5
    critical          = 0
    critical_recovery = 0.5
  }

  require_full_window = false
}



resource "datadog_monitor" "postgres_active_connections" {
  name               = "PostgreSQL Active Connections"
  type               = "metric alert"
  message            = "High number of active connections on {{host.name}}. Investigate immediately."
  escalation_message = "Active connections are still high!"

  query = "avg(last_5m):avg:postgresql.connections{db:${aws_db_instance.pstg_db.identifier}} by {host} >= 90"

  monitor_thresholds {
    critical = 90
    warning  = 85
    ok       = 0
  }

  notify_no_data    = false
  renotify_interval = 20
}

