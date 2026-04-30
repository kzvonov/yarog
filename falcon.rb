#!/usr/bin/env -S falcon host
# frozen_string_literal: true

require "falcon/environment/rack"
require "async/service/supervisor"


service "web" do
  include Falcon::Environment::Rack

  # Number of worker processes (4 for SQLite + WebSockets)
  # Each process can handle hundreds of concurrent connections via fibers
  count ENV.fetch("WEB_CONCURRENCY", 4).to_i

  # Preload Rails before forking workers (reduces memory usage)
  preload "preload.rb"

  port { ENV.fetch("PORT", 3000).to_i }
  endpoint do
    Async::HTTP::Endpoint.parse("http://0.0.0.0", port: port)
  end

  include Async::Service::Supervisor::Supervised
end

service "supervisor" do
  include Async::Service::Supervisor::Environment

  monitors do
    [
      Async::Service::Supervisor::MemoryMonitor.new(
        # Check memory every 30 seconds
        interval: 30,
        # 2GB
        total_size_limit: 2000 * 1024 * 1024,
        # Per-process limit: 512MB
        maximum_size_limit: 512 * 1024 * 1024
      )
    ]
  end
end
