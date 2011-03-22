# A list of JavaScript files.
#
# This is a general-purpose class usually used for minification
# of JS assets.
#
# This is often used with Sinatra, but can work with any other
# web framework.
#
# === Usage example
#
#   files  = Dir['public/js/jquery.*.js']
#   files += Dir['public/js/app.*.js']
#
#   # Say, Main is a Sinatra app or something.
#   Main.set :js_files, JsFiles.new(files,
#     :prefix => '/javascript',
#     :file_prefix => './app/js')
#   Main.js_files.mtime #=> (Time) 2010-09-02 8:00PM
#
# Using in Sinatra:
#
#   class Main < Sinatra::Base
#     register Sinatra::JsFilesSupport
#     serve_jsfiles '/js/app.js', js_files
#   end
#
#   # This returns the compressed script:
#   # $ curl http://localhost:4567/js/app.js
#
# You can also use this in your views:
#
#   <!-- Shows <script> tags -->
#   <%= settings.js_files.to_html %>
#
# Getting the data (for rake tasks perhaps):
#
#   File.open('public/scripts.js', 'w') do |f|
#     f << Main.js_files.combined
#   end
#
#   File.open('public/scripts.min.js', 'w') do |f|
#     f << Main.js_files.compressed
#   end
#
class JsFiles
  attr_accessor :files

  # Creates a JsFiles object based on the list of given files.
  #
  # @param files [Array] A list of string file paths.
  # @example
  #
  #   files  = Dir['public/js/jquery.*.js']
  #   $js_files = JsFiles.new(files)
  #
  def initialize(files, options={})
    @files, @options = files, options
    @options[:prefix] ||= '/js/'
    @options[:file_prefix] ||= '/app/js'
    @options[:file_prefix] = File.expand_path(@options[:file_prefix])
  end

  # @group Metadata methods
  
  # Returns the the modified time of the entire package.
  #
  # @return [Time] The last modified time of the most recent file.
  #
  def mtime
    @files.map { |f| File.mtime(f) }.max
  end

  # Returns a list of the URLs for the package.
  #
  # @example
  #
  #   -# This is the same as calling #to_html.
  #   - Main.js_files.hrefs.each do |href|
  #     %script{:src => href}
  #
  def hrefs
    @files.map { |f|
      path = File.expand_path(f)
      path.gsub! /\.[^\.]*$/, ''
      path.gsub! /^#{ @options[:file_prefix] }/, ''
      File.join @options[:prefix], path + ".js?#{File.mtime(f).to_i}"
    }
  end

  # Returns the <script> tags for the development version.
  #
  # @example
  # 
  #   - if settings.production?
  #     %script{:src => '/js/min.js'}
  #   - else
  #     != Main.js_files.to_html
  #
  def to_html
    hrefs.map { |href| "<script type='text/javascript' src='#{href}'></script>" }.join("\n")
  end

  # @group Output methods

  # Returns the combined source of all the files.
  def combined
    @combined ||= @files.map { |file|
      contents = File.open(file) { |f| f.read }
      contents = CoffeeScript.compile(contents)  if file =~ /\.coffee$/
      contents
    }.join("\n")
  end

  # Returns a combined, minifed source of all the files.
  def compressed
    require 'jsmin'
    @compressed ||= JSMin.minify(combined).strip
  end
end

if defined?(Sinatra)
  # == Example
  #
  #   register Sinatra::JsFilesSupport
  #   serve_jsfiles '/js/app.js'
  #
  module Sinatra::JsFilesSupport
    def self.registered(app)
      app.set :jsfiles_cache_max_age, 86400*30
    end

    def serve_jsfiles(path, jsfiles)
      get path do
        js = settings.js_files

        content_type :js
        last_modified js.mtime
        etag js.mtime.to_i
        cache_control :public, :must_revalidate, :max_age => settings.jsfiles_cache_max_age

        js.compressed
      end
    end
  end
end
