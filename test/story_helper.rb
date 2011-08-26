require 'fileutils'

require_relative 'test_helper'

class StoryTest < UnitTest
  include Capybara::DSL

  Capybara.register_driver :chrome do |app|
    Capybara::Driver::Selenium.new(app, :browser => :chrome)
  end

  def self.javascript_driver
    ENV['CAPYBARA_JS_DRIVER']
  end

  def self.javascript(name='', &blk)
    driver = javascript_driver

    describe("JavaScript tests #{name}") {
      setup { Capybara.current_driver = driver.to_sym }
      teardown { Capybara.use_default_driver }
      yield
    }  if driver
  end

  setup do
    Capybara.app = Main
  end

  # Helpers
  def login!
    visit '/login'

    fill_in 'email',    with: 'liz@mcnamara-troy.com'
    fill_in 'password', with: 'password'

    click_button 'Login'
  end
end
