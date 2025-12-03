require_relative '../pages/ReceiptPage'
require_relative '../pages/BillingPage'

def receipt_page
  @receipt_page ||= ReceiptPage.new
end

def billing_page
  @billing_page ||= BillingPage.new
end


Then(/^I should see the correct billing and shipping information on the receipt:$/) do |table|
  receipt_page.verify_billing_shipping_info(table)
end

And(/^I should see the correct order amounts on the receipt robustly:$/) do |table|

  context = {}
  instance_variables.each do |var|
    next unless var.to_s.start_with?('@')
    context[var.to_s.gsub('@', '')] = instance_variable_get(var)
  end

  receipt_page.verify_order_amounts(table, context)
end

Then(/^I should see the correct product details on the receipt:$/) do |table|
  # Misma lógica de contexto
  context = {}
  instance_variables.each do |var|
    next unless var.to_s.start_with?('@')
    context[var.to_s.gsub('@', '')] = instance_variable_get(var)
  end

  receipt_page.verify_product_details(table, context)
end

Then(/^I click for return on the "Return to Home Page" button$/) do
  receipt_page.return_to_home
end