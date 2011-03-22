require 'fileutils'

require File.expand_path('../helper', __FILE__)

class StoryTest < UnitTest
  include Capybara
  #Capybara.default_driver = :selenium

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
