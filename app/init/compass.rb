require_relative 'encoding'

# Add the compass CSS folder to the path
Gem.activate 'compass'
path = File.join(Gem.loaded_specs['compass'].full_gem_path, 'frameworks/compass/stylesheets')

hash = Main.respond_to?(:scss) ? Main.scss : Hash.new
hash[:load_paths] ||= Array.new
hash[:load_paths] << path

Main.set :scss, hash
