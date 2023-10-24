resource "datadog_monitor" "lb_5xx_errors" {
  name    = "High number of 5xx errors"
  type    = "metric alert"
  message = "High number of 5xx errors detected for Load Balancer my-lb"
  query   = "sum(last_5m):aws.elb.httpcode_elb_5xx_count{loadbalancer:my-lb} >= 10"
  tags    = ["env:production"]

  monitor_thresholds {
    critical = 10
  }
}

resource "datadog_monitor" "http_check" {
  name    = "Http checking new updated"
  type    = "service check"
  message = "Service checking"
  query   = "\"datadog.agent.up\".over(\"*\").by(\"host\").last(2).count_by_status()"

  monitor_thresholds {
    critical = 1
    warning  = 0.5
    ok       = 0
  }

  notify_no_data    = true
  renotify_interval = 60
  notify_audit      = false
  timeout_h         = 24
  include_tags      = true
}

resource "datadog_monitor" "postgres_active_connections" {
  name               = "PostgreSQL Active Connections"
  type               = "metric alert"
  message            = "High number of active connections on {{host.name}}. Investigate immediately."
  escalation_message = "Active connections are still high!"

  query = "avg(last_5m):avg:postgresql.connections{db:${aws_db_instance.postgres_db.identifier}} by {host} >= 90"

  monitor_thresholds {
    critical = 90
    warning  = 85
    ok       = 0
  }

  renotify_interval = 20
}

resource "datadog_dashboard" "app_health_dashboard" {
  title       = "Application Health"
  description = "A Dashboard to monitor application health."
  layout_type = "ordered"

  widget {
    alert_graph_definition {
      alert_id = datadog_monitor.http_check.id
      title    = "HTTP Health Check"
      viz_type = "timeseries"
    }
  }

  widget {
    alert_value_definition {
      alert_id  = datadog_monitor.lb_5xx_errors.id
      precision = 2
      unit      = "error"
      title     = "Load Balancer 5xx Errors"
    }
  }

  widget {
    alert_value_definition {
      alert_id  = datadog_monitor.postgres_active_connections.id
      precision = 2
      unit      = "connections"
      title     = "Postgres Active Connections"
    }
  }

  template_variable {
    name     = "env"
    prefix   = "host"
    defaults = ["production"]
  }
}
