class Main
  module JsCdnHelpers
    def js_cdn(name)
      opts = settings.js_packages[name.to_sym]
      return "<!-- Unknown JS package: #{name} -->"  unless opts

      if settings.development? && File.exists?(Main.root('app', opts[:fallback]))
        "<script type='text/javascript' src='#{opts[:fallback]}'></script>"
      else
        str =  "<script type='text/javascript' src=\"#{opts[:remote]}\"></script>"
        str += "<script>!#{opts[:test]} && document.write('<script src=\"#{opts[:fallback]}\"><\\/script>')</script>"  unless opts[:test].nil?
        str
      end
    end
  end

  helpers JsCdnHelpers
end
