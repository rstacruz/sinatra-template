ENV["RACK_ENV"] = "test"
require File.expand_path("../../init", __FILE__)

require 'capybara/dsl'

class UnitTest < Test::Unit::TestCase
  def fixture(file)
    File.open fixture_path(file)
    end

  def fixture_path(file)
    Main.root "test", "fixtures", file
  end
end
