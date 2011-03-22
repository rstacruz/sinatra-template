task :test => :start_app do
  require "cutest"
  Cutest.run(Dir["test/*_test.rb"])
end

task :start_app => :runner do
  require "./test/fixtures/sinatra/app.rb"
  require "./test/fixtures/rackapp/app.rb"
  require "./test/fixtures/cuba/app.rb"
  require "logger"

  logger = ::Logger.new(File.open("/dev/null", "w"))

  run(App.new, 9595, logger)
  run($rackapp, 9696, logger)
  run(Cuba, 9797, logger)

  # Let's simply wait for the sinatra app to start.
  sleep 2
end

task :runner do
  def run(app, port, logger)
    Thread.new do
      Rack::Handler::WEBrick.run(app,
        :Port => port,
        :Logger => logger,
        :AccessLog => []
      )
    end
  end
end

task :default => :test