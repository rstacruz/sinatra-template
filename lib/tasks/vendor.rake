def get(url, options={})
  require 'fileutils'
  target = options[:as]

  puts "* #{target}..."
  FileUtils.mkdir_p File.dirname(target)
  system "wget \"#{url}\" -O \"#{target}\""
end

desc "Vendor JS libraries"
task :vendor, :library do |_, args|
  require './init'

  lib = args[:library]
  lib = lib.to_sym  if lib

  packages = Main.js_packages

  if lib
    options = packages[lib]
    unless options
      puts "Don't know the library #{lib}."
      exit
    end

    get options[:remote], as: options[:fallback]

  else
    packages.each { |name, options|
      get options[:remote], as: options[:fallback]
    }
  end

  puts "Done."
end
