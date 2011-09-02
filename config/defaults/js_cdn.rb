class Main
  GOOGLE_CDN = "http://ajax.googleapis.com/ajax/libs/%s"
  CC_CDN     = "http://cachedcommons.org/cache/%s/javascripts/%s"

  set :js_packages, {
    jquery: {
      remote:   GOOGLE_CDN % ["jquery/1.6.2/jquery.min.js"],
      fallback: '/js/vendor/jquery.js',
      test:     'window.jQuery'
    },
    jquery_ui: {
      remote:   GOOGLE_CDN % ["jqueryui/1.8.5/jquery-ui.min.js"],
      fallback: '/js/vendor/jquery-ui.js',
      test:     'window.jQuery.fn.sortable'
    },
    underscore: {
      remote:     CC_CDN % ["underscore/1.1.7", 'underscore-min.js'],
      fallback:   '/js/vendor/underscore.js',
      test:       'window._'
    },
    modernizr: {
      remote:     CC_CDN % ["modernizr/2.0.6", 'modernizr-min.js'],
      fallback:   '/js/vendor/modernizr.js'
    },
    dd_belated_png: {
      remote:     CC_CDN % ["dd-belated-png/0.0.8", 'dd-belated-png-min.js'],
      fallback:   '/js/vendor/dd-belated-png.js',
      test:       'window.DD_belatedPNG'
    }
    }
end
