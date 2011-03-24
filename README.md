# Sinatra template

Here's how to use this template:

    git clone --depth 1 http://github.com/rstacruz/sinatra-template.git myproject
    rm -r myproject/.git

    # Eventually get rid of this README file
    mv README.example.md README.md

Welcome!
========

**Hack away!** Remove this screen by editing `app/routes/site.rb`
and `app/views/home.haml`.

Some views were set up for you that use [Haml](http://haml-lang.com/)
(for HTML) and [SASS / SCSS](http://sass-lang.com) (for CSS).

Skeleton Info
-------------

### ORM-less

The skeleton comes with no ORM by default.

However, there are sample initializers in `app/init/` and config files in
`config/` for Ohm and Sequel. See those files for instructions.

### Sinatra-style configuration

The bootstrapper loads all of `config/*.rb`, starting with the default
files (like `haml.default.rb`).

 * To set settings: `Main.set :name, "Hello"`
 * To retrieve settings: `settings.name`

### JS Minification

Uses JsFiles (to compress JS files). This supports CoffeeScript support by the 
way.

 * Edit `config/jsfiles.defaults.rb` to see which JS files are to be processed.

### HTML5 boilerplate

Some things from the HTML5 boilerplate were roughly followed:

 * Modernizr built in
 * Load JQuery/Modernizr/etc via CDN (Google's and Cachedcommon's public CDNs)
 * DD_belatedPNG
 * ...among other things (which should be fairly trivial to remove)

### CoffeeScript support

Dump your CoffeeScripts to `/app/js`. The file `yourfile.coffee` will be 
available in `http://localhost:4567/js/yourfile.js`.

Be sure to add `gem "coffee-script", require: "coffee_script"` to your Gemfile 
if you need this.

### Sass/SCSS/Less support

Dump your Less, SCSS, or Sass files onto `/app/css`. Watch `hello.sass` show 
up on `http://localhost:4567/css/hello.css`.

Be sure to add `gem "less"` to your Gemfile if you need Less.

### Structure

    ./
    |- app/
    |  |- init/           - Initializers (akin to Rails config/initializers)
    |  |- models/         - Models
    |  |- routes/         - Sinatra routes (akin to Rails controllers)
    |  |- helpers/        - Helper modules
    |  |- views/          - Views and layouts (haml, erb, etc)
    |  |- css/            - Stylesheets served under /css
    |  `- js/             - JS files served under /js
    |
    |- vendor/
    |  |- gems/           - Gems that are stored in the repo
    |  `- plugins/        - Reuseable plugins
    |
    |- config/            - Configuration files (*.rb)
    |- lib/               - General purpose libraries
    |- public/            - Static assets
    |- test/
    `- init.rb

The main file is `init.rb` -- just run it to start the server.
When init.rb is loaded, it:

 - loads `*.defaults.rb` in `config/` to load default settings
 - loads `*.rb` in `config/` to load user settings -- these files are gitignore'd
 - loads `*.rb` in `app/init/` to initialize stuff
 - loads `*.rb` in `app/` (recursive) to load routes and models
 - starts the server

### And more

 * The jQuery helpers ensure that jQuery is loaded from Google servers first before
   falling back to the app-provided jQuery file.

 * Uses AgentSniff to do browser detection. The HTML class is automatically set.
