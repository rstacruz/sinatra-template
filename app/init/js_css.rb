class Main
  register Sinatra::JsSupport
  serve_js '/js', from: root('app/js')

  register Sinatra::CssSupport
  serve_css '/css', from: root('app/css')

  register Sinatra::CompressedJS
  serve_compressed_js :app_js,
    :path   => '/js/app.js',
    :prefix => '/js',
    :root   => root('app/js'),
    :files  =>
      Dir[root('app/js/vendor/jquery.*.*')].sort +
      Dir[root('app/js/lib/*.*')].sort +
      Dir[root('app/js/app/*.*')].sort
end
