Pistol
======

_n. A small tool designed to reload your rack application._

Get it!
-------

    $ gem install pistol

Usage
-----

    # app.rb
    require "sinatra/base"
    require "pistol"

    class App < Sinatra::Base
      use Pistol, :files => Dir[__FILE__, "./app/**/*.rb"]
    end

    Dir["./app/**/*.rb"].each { |file| require file }

### What this does:

1. It marks `app.rb` as the main application file. It's assumed that app.rb
   handles all the loading, boiler plate, etc.
2. It reloads everything in `app/**/*.rb`. You can of course specify
   other paths (e.g. `./config/*.rb`, `./lib/*.rb`).

### Only in development?

Sure. Simply change it to:

    class App < Sinatra::Base
      configure :development do
        use Pistol, :files => Dir[__FILE__, "./app/**/*.rb"]
      end
    end