
After do 
    Capybara.current_session.driver.quit
end

Before '@maximize' do
  page.driver.browser.manage.window.maximize
end

AfterStep('@slow') do
  sleep 1.5
end

AfterStep('@debug') do |result, step|
  puts "Completado paso: #{step.text}"
end