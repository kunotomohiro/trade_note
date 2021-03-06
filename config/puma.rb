# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

unless ENV['RAILS_ENV'] == "development"
  workers Integer(ENV['WEB_CONCURRENCY'] || 2)
  preload_app!
  rackup      DefaultRackup
  app_dir = File.expand_path("../..", __FILE__)
  bind "unix://#{app_dir}/tmp/sockets/puma.sock"
  pidfile "#{app_dir}/tmp/pids/puma.pid"
  state_path "#{app_dir}/tmp/pids/puma.state"
  stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true
end

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
if ENV['RAILS_ENV'] != "production"
  port        ENV.fetch("PORT") { 3000 }
end
environment ENV['RAILS_ENV'] || 'development'
# Specifies the `environment` that Puma will run in.
#
# environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
# pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

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

if ENV['RAILS_ENV'] == "production"
  before_fork do
    PumaWorkerKiller.config do |config|
      config.ram           = 1024 # mb
      config.frequency     = 5 * 60    # seconds
      config.percent_usage = 0.90
      config.rolling_restart_frequency = 24 * 3600 # 12 hours in seconds, or 12.hours if using Rails
      config.reaper_status_logs = true # setting this to false will not log lines like:
      # PumaWorkerKiller: Consuming 54.34765625 mb with master and 2 workers.
    end
    PumaWorkerKiller.start
    ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
  end
  on_worker_boot do
    ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
  end
end