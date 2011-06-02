require './lib/log_helpers'
extend LogHelpers

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
