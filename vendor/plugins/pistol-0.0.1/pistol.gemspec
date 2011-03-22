Gem::Specification.new do |s|
  s.name = "pistol"
  s.version = "0.0.1"
  s.summary = %{The light tool for the reloading job.}
  s.description = %Q{Extremely lightweight reloading tool for rack &
                     sinatra apps.}
  s.authors = ["Michel Martens", "Damian Janowski", "Cyril David"]
  s.email = ["michel@soveran.com", "djanowski@dimaion.com",
             "cyx@pipetodevnull.com"]
  s.homepage = "http://github.com/monk/pistol"
  s.files = ["lib/pistol.rb", "README.markdown", "LICENSE", "Rakefile", "test/fixtures/helloworld/app/article.rb", "test/fixtures/helloworld/app.rb", "test/fixtures/helloworld/lib/article.rb", "test/fixtures/helloworld/lib/book.rb", "test/helper.rb", "test/pistol_test.rb", "test/sinatra_test.rb"]

  s.rubyforge_project = "pistol"
  s.add_development_dependency "cutest", "~> 1.0"
  s.add_development_dependency "sinatra", "~> 1.0"
end