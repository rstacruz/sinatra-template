require 'jsfiles'
require 'sinatra/support/csssupport'
require 'sinatra/support/jssupport'

class Main
  set :js_files, JsFiles.new(
    js_files_list,
    :prefix => '/js',
    :file_prefix => root('app/js'))

  register Sinatra::JsSupport
  serve_js '/js', from: root('app/js')

  register Sinatra::CssSupport
  serve_css '/css', from: root('app/css')

  register Sinatra::JsFilesSupport
  serve_jsfiles '/js/app.js', js_files
end
