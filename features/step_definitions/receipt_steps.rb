# Background Steps
Given(/^I am on the GMO Home Page$/) do
  visit('/')
end

# Step genérico para botones
When(/^I click on the "([^"]*)" button$/) do |button_name|
  click_button(button_name)
end

# Order Quantities
Given(/^I enter the order quantities as show below:$/) do |table|
  @form.fill_in_fields(table, Form::ORDER_QUANTITIES_FIELDS)
end

# Billing Information Steps
Given(/^I am at "([^"]*)" Page$/) do |page_name|
  expect(page).to have_content(page_name)
end

When(/^I enter the bill to information as shown below:$/) do |table|
  @form.fill_in_fields(table, Form::BILLING_FIELDS)
end

When(/^I check the "([^"]*)" checkbox$/) do |checkbox_name|
  check(checkbox_name)
end


Then(/^I should see the following billing information on the receipt:$/) do |table|
  # CORRECCIÓN: Cambiar el texto esperado
  expect(page).to have_content('OnLine Store Receipt')
  
  # Usar el mismo método que funciona para shipping
  path_table = "/html/body/table[2]/tbody/tr[1]/td/div/center/table/tbody/tr[%i]/td[%i]"
  @form.compare_fields_with_table(
    table,
    Form::RECEIPT_BILLING_COLUMNS,  # Asegúrate de que esta constante exista
    path_table
  )
end

Then(/^I should see the following shipping information on the receipt:$/) do |table|
  path_table = "/html/body/table[2]/tbody/tr[1]/td/div/center/table/tbody/tr[%i]/td[%i]"
  @form.compare_fields_with_table(
    table,
    Form::RECEIPT_SHIPPING_COLUMNS,
    path_table
  )
end

Then(/^I click for return on the "Return to Home Page" button$/) do
  click_button('Return to Home Page')
end