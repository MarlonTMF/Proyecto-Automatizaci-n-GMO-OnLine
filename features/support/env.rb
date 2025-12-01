begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'

Capybara.default_driver = :selenium

Capybara.app_host = ENV["CAPYBARA_HOST"]

Capybara.default_max_wait_time = 15
Capybara.default_driver = :selenium
Capybara.app_host = "http://demo.borland.com/gmopost/"

class CapybaraDriverRegistrar
  
  def self.register_selenium_driver(browser)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => browser)
    end
  end

end

CapybaraDriverRegistrar.register_selenium_driver(:chrome)
Capybara.run_server = false


