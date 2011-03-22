# Support for Sass/SCSS/Less.
#
# == Example
#
#   require 'sinatra/csssupport'
#
#   register Sinatra::CssSupport
#   serve_css '/css', from: root('app/css')
#
#   # reads app/css/style.css (or .scss, .sass, .less)
#   $ curl "http://localhost:4567/css/style.css"
#
module Sinatra::CssSupport
  def self.registered(app)
    app.set :css_max_age, 86400*30
  end

  def serve_css(url_prefix, options={})
    path   = File.join(url_prefix, '*.css')
    prefix = options[:from]

    get path do |name|
      fname = Dir[File.join(prefix, "#{name}.{css,scss,less}")].first  or pass

      content_type :css, :charset => 'utf-8'
      last_modified File.mtime(fname)
      cache_control :public, :must_revalidate, :max_age => settings.js_max_age

      if fname =~ /\.scss$/
        scss File.read(fname)
      elsif fname =~ /\.scss$/
        sass File.read(fname)
      elsif fname =~ /\.less$/
        less File.read(fname)
      else
        send_file fname
      end
    end
  end
end
