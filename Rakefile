desc "Run all tests"
task(:test) {
  Dir['./test/**/*_test.rb'].each { |f| load f }
}

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

Dir['./lib/tasks/**/*.rake'].each { |f| load f }
