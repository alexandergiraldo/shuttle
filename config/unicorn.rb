preload_app true
worker_processes Integer(ENV["UNICORN_WORKERS"] || 3)
timeout 30

before_fork do |server, worker|

  # Only for staging
  # Running free background jobs on heroku
  # https://coderwall.com/p/fprnhg
  if Rails.env.production?
    @sidekiq_pid ||= spawn("bundle exec sidekiq -C ./config/sidekiq.yml")
  end

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end