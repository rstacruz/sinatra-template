class Main
  files  = Dir[root(%w[app js vendor jquery.*.*])]
  files += Dir[root(%w[app js lib *.*])]
  files += Dir[root(%w[app js app *.*])]

  set :js_files_list, files
end
