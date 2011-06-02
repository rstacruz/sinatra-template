ENV["RACK_ENV"] = "test"
require 'bundler'
Bundler.require :default, :test

Spork.prefork do
end

Spork.each_run do
end

require_relative '../init'
require 'capybara/dsl'

class UnitTest < Test::Unit::TestCase
  def fixture(file)
    File.open fixture_path(file)
    end

  def fixture_path(file)
    Main.root "test", "fixtures", file
  end
end
