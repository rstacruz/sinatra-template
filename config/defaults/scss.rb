class Main
  set :scss, { :load_paths => [ root('vendor/plugins/compass_framework'), root('app/css') ] }
  set :scss, self.scss.merge(:line_numbers => true, :debug_info => true, :always_check => true) if self.development?
  set :scss, self.scss.merge(:style => :compressed) if self.production?
end