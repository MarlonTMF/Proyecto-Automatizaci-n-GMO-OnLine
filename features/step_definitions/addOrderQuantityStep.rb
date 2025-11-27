require_relative '../pages/CatalogPage'

def catalog
  @catalog ||= CatalogPage.new
end

Given('I am on the GMO Home Page') do
  catalog.visit_home
end

Given('I click on the {string} button') do |btn|
  case btn
  when "Place An Order" then catalog.click_place_order
  when "Enter GMO OnLine" then catalog.click_enter_gmo
  else click_button btn
  end
end

When(/^I (?:enter|remove) the order quantities as (?:show|shown) below:$/) do |table|
  catalog.enter_quantities(table)
end

Then('I should see the following quantities:') do |table|
  xpath = "//body//form//table//table//tr[%s]/td[%s]"
  catalog.compare_fields_with_table(table, 2, CatalogPage::SUMMARY_MAPPING, xpath)
end

Then('I should see the following message {string}') do |msg|
  sleep 0.5
  begin
    expect(catalog.get_alert_message).to eq(msg)
    catalog.accept_alert_popup
  rescue Selenium::WebDriver::Error::NoSuchAlertError
    expect(page).to have_content(msg)
  end
end