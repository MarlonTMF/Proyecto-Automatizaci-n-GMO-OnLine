require 'fileutils'

Before do
  page.driver.browser.manage.window.maximize
end

Before '@maximize' do
  page.driver.browser.manage.window.maximize
end

AfterStep('@slow') do
  sleep 1.5
end

AfterStep('@debug') do |result, step|
  puts "Step completed: #{step.text}"
end

