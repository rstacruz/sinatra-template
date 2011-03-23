# Rename this file to 'sequel.defaults.rb' to use Sequel.
require 'sequel'

Main.configure do |m|
  Dir.mkdir Main.root('db')  unless File.directory?(Main.root('db'))
  m.set :sequel, "sqlite://db/development.db"
end

# To define a different server for prod:
# Main.configure(:production) do |m|
#   require 'mysql'
#   m.set :sequel, "mysql://root@localhost/db"
# end

Main.set :db, Sequel.connect(ENV['DATABASE_URL'] || Main.sequel)
Sequel.extension :inflector

# More examples:
#
#   m.set :sequel, "mysql://root:password@localhost/db_name"
#   m.set :sequel, "postgres://user:password@localhost/db_name"

