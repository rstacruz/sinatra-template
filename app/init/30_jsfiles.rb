class Main
  set :js_files, JsFiles.new(
    js_files_list,
    :prefix => '/js',
    :file_prefix => root('./app/js'))
end
