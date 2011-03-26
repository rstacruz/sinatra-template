require 'fileutils'

require File.expand_path('../helper', __FILE__)

class StoryTest < UnitTest
  include Capybara

  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Driver::Selenium.new(app, :browser => :chrome)
  end

  case ENV['CAPYBARA_DRIVER']
    when 'chrome'  then Capybara.default_driver = :selenium_chrome
    when 'firefox' then Capybara.default_driver = :selenium
  end

  def self.javascript?
    [:selenium, :selenium_chrome].include?(Capybara.default_driver)
  end

  def self.javascript(name='', &blk)
    describe("JavaScript tests #{name}") { yield }   if javascript?
  end

  setup do
    Capybara.app = Main
  end

  def dump_page
    str = page.body

    file = File.open("/tmp/out-#{rand.to_s[2..-1]}.html", 'w') 
    file.write str
    file.close

    system "open #{file.path}"
  end

  def login!
    visit '/login'

    fill_in 'email',    with: 'liz@mcnamara-troy.com'
    fill_in 'password', with: 'password'

    click_button 'Login'
  end
end
