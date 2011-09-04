require './lib/log_helpers'
extend LogHelpers

Dir['./lib/tasks/**/*.rake'].each { |f| load f }
task :default => :help

# You may want to remove this crap, it has no use in production.

desc "Starts the server [Development]"
task(:start) {
  system "ruby init.rb"
}

desc "Opens a console session [Development]"
task(:irb) {
  irb = ENV['IRB_PATH'] || 'irb'
  system "#{irb} -r./init.rb"
}

desc "Lists available recipes [Recipe]"
task(:recipes) {
  puts "Available recipes:"
  list = Dir['./**/*.example'].map { |f| File.basename(f).match(/([^\.]+)(.[^\.]+){2}$/) && $1 }.uniq
  list.each { |item| puts " * rake recipes:load[#{item}]" }
}

namespace :recipes do
  desc "Clears all example files [Recipe]"
  task :clear do
    Dir['./**/*.example'].each { |f| FileUtils.rm f }
  end

  desc "Loads a given recipe [Recipe]"
  task :load, :recipe do |t, args|
    recipe = args[:recipe]
    Dir["./**/*#{recipe}.*.example"].each { |from|
      to = from.gsub(/(\.#{recipe})|(\.example)/, '')
      puts "%40s -> %s" % [ from, to ]
      FileUtils.mv from, to  unless ENV['SIMULATE']
    }
    puts "Okay, now add the appropriate gems to your gemfile."
  end
end
