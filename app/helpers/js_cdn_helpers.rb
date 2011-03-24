class Main
  module JsCdnHelpers
    GOOGLE_CDN = "http://ajax.googleapis.com/ajax/libs/%s"
    CC_CDN     = "http://cachedcommons.org/cache/%s/javascripts/%s"

    def jquery(version='1.5.1')
      cdn_js :remote    => GOOGLE_CDN % ["jquery/#{version}/jquery.min.js"],
             :fallback  => '/js/vendor/jquery.js',
             :test      => 'window.jQuery'
    end

    def jquery_ui(version='1.8.5')
      cdn_js :remote   => GOOGLE_CDN % ["jqueryui/#{version}/jquery-ui.min.js"],
             :fallback => '/js/vendor/jquery-ui.js',
             :test     => 'window.jQuery.fn.sortable'
    end

    def underscore(version='1.1.0')
      cdn_js :remote   => CC_CDN % ["underscore/#{version}", 'underscore-min.js'],
             :fallback => '/js/vendor/underscore.js',
             :test     => 'window._'
    end

    def modernizr(version='1.5.0')
      cdn_js :remote   => CC_CDN % ["modernizr/#{version}", 'modernizr-min.js'],
             :fallback => '/js/vendor/modernizr-min.js'
    end

    def dd_belatedpng(version='0.0.8')
      cdn_js :remote   => CC_CDN % ["dd-belated-png/#{version}", 'dd-belated-png-min.js'],
             :fallback => '/js/vendor/dd-belated-png-min.js',
             :test     => 'window.DD_belatedPNG'
    end

    def cdn_js(opts={})
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
