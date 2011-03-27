require './lib/task_helpers'

desc "Run all tests [Testing]"
task(:test) {
  Dir['./test/**/*_test.rb'].each { |f| load f }
}

namespace(:test) do
  [ :chrome, :firefox ].each do |driver|
    desc "Run all tests with JS tests in #{driver.to_s.capitalize} [Testing]"
    task(driver) {
      ENV['CAPYBARA_DRIVER'] = driver.to_s
      Dir['./test/**/*_test.rb'].each { |f| load f }
    }
  end
end

desc "Starts the server [Development]"
task(:start) {
  system "ruby init.rb"
}

desc "Opens a console session [Development]"
task(:irb) {
  irb = ENV['IRB_PATH'] || 'irb'
  system "#{irb} -r./init.rb"
}

Dir['./lib/tasks/**/*.rake'].each { |f| load f }
task :default => :help
