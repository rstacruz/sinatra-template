desc "Run all tests"
task(:test) {
  Dir['./test/**/*_test.rb'].each { |f| load f }
}

namespace(:test) do
  [ :chrome, :firefox ].each do |driver|
    desc "Run all tests with JS tests in #{driver.to_s.capitalize}"
    task(driver) {
      ENV['CAPYBARA_DRIVER'] = driver.to_s
      Dir['./test/**/*_test.rb'].each { |f| load f }
    }
  end
end

desc "Starts the server"
task(:start) {
  system "ruby init.rb"
}

desc "Opens a console session"
task(:irb) {
  irb = ENV['IRB_PATH'] || 'irb'
  system "#{irb} -r./init.rb"
}

task :default => :test

require './lib/task_helpers'

Dir['./lib/tasks/**/*.rake'].each { |f| load f }
