ENV['RACK_ENV'] ||= 'development'

# Loadables
$:.unshift *Dir["./vendor/*/*/lib"]
$:.unshift *Dir["./lib"]

# Bundler
require "bundler"
Bundler.require :default, ENV['RACK_ENV'].to_sym

# Plugins
require "rtopia"
require "jsfiles"
require "user_agent"

# Sinatra-ext
require 'sinatra/csssupport'
require 'sinatra/jssupport'

class Main < Sinatra::Base
  set      :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }
  set      :views, root('app', 'views')
  set      :run, lambda { __FILE__ == $0 and not running? }

  enable   :raise_errors, :sessions, :logging,
           :show_exceptions, :raise_errors

  use      Rack::Session::Cookie
  helpers  Rtopia
  helpers  Sinatra::ContentFor        # sinatra-content_for
  helpers  Sinatra::UserAgentHelpers  # agentsniff

  # Load all, but load defaults first
  Dir[root('config', '{*.defaults,*}.rb')].uniq.each { |f| load f }

  configure :development do
    require 'pistol'
    use(Pistol, Dir["./{lib,app}/**/*.rb"]) { reset! and load(__FILE__) }
  end

  register Sinatra::JsSupport
  serve_js '/js', from: root('app/js')

  register Sinatra::CssSupport
  serve_css '/css', from: root('app/css')

  register Sinatra::JsFilesSupport
  serve_jsfiles '/js/app.js', js_files
end

Dir["./app/{init/,}**/*.rb"].each { |rb| require rb }

Main.set :port, ENV['PORT'].to_i  unless ENV['PORT'].nil?
Main.run!  if Main.run?
