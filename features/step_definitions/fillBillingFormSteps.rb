puts "STEP FILE LOADED"

When(/^I enter the shipping to information as shown below:$/) do |table|
  @form.fill_in_fields(table, SHIPPING_FIELDS)
end

When(/^I enter the bill to information as shown below:$/) do |table|
  @form.fill_in_fields(table, BILLING_FIELDS)
end

Then('The billing information should be copied to the shipping fields as shown below:') do |table|
    start_row = 2
    path_table = '/html/body/form/table/tbody/tr[2]/td[3]/table/tbody/tr[%i]/td[%i]/input'
    @form.compare_fields_with_table(
    table,
    start_row,
    COLUMNS_SHIPPING,
    path_table
    )
end

Then(/^I should see the following message "([^"]*)"$/) do |message|
  # Espera un momento para que aparezca la alerta
  sleep 2
  
  begin
    # Captura la alerta
    alert = page.driver.browser.switch_to.alert
    alert_text = alert.text
    
    # Verifica que el mensaje coincida
    expect(alert_text).to eq(message)
    
    # Acepta la alerta para cerrarla
    alert.accept
    
  rescue Selenium::WebDriver::Error::NoSuchAlertError
    # Si no hay alerta, verifica si el mensaje está en la página
    if page.has_content?(message)
      puts "✅ Mensaje encontrado en la página: #{message}"
    else
      raise "No se encontró la alerta. Mensaje esperado: #{message}"
    end
  end
end