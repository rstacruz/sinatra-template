require Main.root('app/init/sequel.rb')

if Main.test?
  Main.database = "sqlite://db/test.db"
else
  Main.database = ENV['DATABASE_URL'] || "sqlite://db/development.db"
end
