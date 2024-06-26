# typed: false
# frozen_string_literal: true

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads(min_threads_count, max_threads_count)

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
worker_timeout(3600) if ENV.fetch("RAILS_ENV", "development") == "development"

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port(ENV.fetch("PORT") { 3000 })

# Specifies the `environment` that Puma will run in.
#
environment(ENV.fetch("RAILS_ENV") { "development" })

# Specifies the `pidfile` that Puma will use.
pidfile(ENV.fetch("PIDFILE") { "tmp/pids/server.pid" })

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `bin/rails restart` command.
plugin(:tmp_restart)

# Disable the queueing of requests to have the right values from the `raindrops` metrics.
# https://github.com/shopify/shopify_metrics#spawn-raindrops-monitor-thread
# Disabling the request queueing config does two things regarding the raindrops metrics:
# - disables the buffer that accepts connections before they can be worked on. With the buffer enabled,
#   all connections in the buffer are considered active instead of queued.
# - disabled Keep-Alive. As the ingress annotation with the keep-alive mode, this will count the connections
#   kept as active connections and will wrongly push the raindrops utilization up.
#
queue_requests(false)

if Rails.env.production?
  # Enable shopify metrics: https://github.com/Shopify/shopify_metrics#puma-plugin
  plugin(:shopify_metrics)

  # Spawn Raindrops monitor thread
  # https://github.com/Shopify/shopify_metrics#spawn-raindrops-monitor-thread
  before_fork { ShopifyMetrics::RaindropsMonitor.init }
end
