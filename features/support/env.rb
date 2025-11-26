begin 
  require 'rspec/expectations'
rescue LoadError
  require 'spec/expectations'
end

require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'selenium-webdriver'
require_relative 'form'

# Configuración MUY simple - sin opciones complejas
Capybara.configure do |config|
  config.default_driver = :selenium
  config.app_host = "http://demo.borland.com/gmopost/"  
  config.default_max_wait_time = 10
  config.run_server = false
end

# Driver simple sin opciones que causen conflicto
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# Inicializar @form de manera confiable
Before do
  @form = Form.new
end

World do
  @form = Form.new
end