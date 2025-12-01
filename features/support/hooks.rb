
After do 
    Capybara.current_session.driver.quit
end


Before do
  @form = Form.new
end