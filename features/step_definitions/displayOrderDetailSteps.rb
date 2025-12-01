require_relative '../pages/PlaceOrderPage'

def place_order_page
  @place_order_page ||= PlaceOrderPage.new
end

Then('I should see the following order summary table:') do |table|
  place_order_page.verify_order_details(table)
end