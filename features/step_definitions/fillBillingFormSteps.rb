require_relative '../pages/BillingPage'

def billing_page
  @billing_page ||= BillingPage.new
end

Given(/^I am at "([^"]*)" Page$/) do |expected_title_page|
  expect(page).to have_content(expected_title_page)
end

When(/^I enter the shipping to information as shown below:$/) do |table|
  billing_page.fill_shipping_info(table)
end

When(/^I enter the bill to information as shown below:$/) do |table|
  billing_page.fill_billing_info(table)
end

And(/^I check the "([^"]*)" checkbox$/) do |checkbox_name|
    if checkbox_name == "shipSameAsBill"
        billing_page.check_same_as_bill
    else
        check checkbox_name
    end
end

Then('The billing information should be copied to the shipping fields as shown below:') do |table|
  billing_page.verify_shipping_data(table)
end

Then(/^I should see the following message "([^"]*)"$/) do |message|
    sleep 0.5
    begin
      alert = page.driver.browser.switch_to.alert
      expect(alert.text).to eq(message)
      alert.accept
    rescue Selenium::WebDriver::Error::NoSuchAlertError
      expect(page).to have_content(message)
    end
end