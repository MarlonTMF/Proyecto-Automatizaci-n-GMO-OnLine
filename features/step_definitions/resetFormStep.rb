require_relative '../pages/CatalogPage'

def catalog
  @catalog ||= CatalogPage.new
end

Then('I should see the following fields reset to default:') do |table|
  catalog.verify_quantities_are_reset(table)
end