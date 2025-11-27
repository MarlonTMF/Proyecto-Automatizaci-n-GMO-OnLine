require_relative '../pages/CatalogPage'
def catalog
  @catalog ||= CatalogPage.new
end

Given('I am at {string} Page') do |page_name|
  catalog.verify_page_content(page_name)
end

Given('I go back to the previous page') do
  catalog.go_back
end

When('I change the order quantities as shown below:') do |table|
  catalog.enter_quantities(table)
end

Then('I should see the updated quantities:') do |table|
  xpath_template = "//body//form//table//table//tr[%s]/td[%s]"
  start_row = 2
  catalog.compare_fields_with_table(table, start_row, CatalogPage::SUMMARY_MAPPING, xpath_template)
end