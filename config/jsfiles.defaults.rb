class Main
  files = Dir[root(%w[public js {jquery,lib,app}.*.js])]
  set :js_files, JsFiles.new(files, :prefix => '/js/')
end
