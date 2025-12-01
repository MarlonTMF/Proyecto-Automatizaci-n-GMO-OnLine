
Given(/^I am on the GMO Home Page$/) do
  visit('/')
end
Given('I enter the order quantities as show below:') do |table|
  table.hashes.each do |row|
    product_name = row['Product Name']
    quantity = row['Quantity']
    
    
    if product_name == '3 Person Dome Tent'
      fill_in('QTY_TENTS', with: quantity)
   
    else
      
      field_name = "QTY_#{product_name.upcase.gsub(' ', '_')}"
      fill_in(field_name, with: quantity)
    end
  end
end

And(/^I click on the "([^"]*)" button$/) do |button_name|
  click_button(button_name) 
end

And(/^I am at "([^"]*)" Page$/) do |expected_title_page|
  expect(page).to have_content(expected_title_page)
end

And(/^I check the "([^"]*)" checkbox$/) do |checkbox_name|
  check(checkbox_name) 
end

