require 'jsfiles'
require 'sinatra/csssupport'
require 'sinatra/jssupport'

class Main
  register Sinatra::JsSupport
  serve_js '/js', from: root('app/js')

  register Sinatra::CssSupport
  serve_css '/css', from: root('app/css')

  register Sinatra::JsFilesSupport
  serve_jsfiles '/js/app.js', js_files
end
