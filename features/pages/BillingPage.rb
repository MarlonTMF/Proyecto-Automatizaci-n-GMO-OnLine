require_relative 'Form'

class BillingPage < Form
  COLUMNS_SHIPPING = {
    "Name" => 2, "Address" => 2, "City" => 2,
    "State" => 2, "Zip" => 2, "Phone" => 2
  }

  SHIPPING_FIELDS = {
    "Name" => { "id" => "shipName", "type" => "input" },
    "Address" => { "id" => "shipAddress", "type" => "input" },
    "City" => { "id" => "shipCity", "type" => "input" },
    "State" => { "id" => "shipState", "type" => "input" },
    "Zip" => { "id" => "shipZipCode", "type" => "input" },
    "Phone" => { "id" => "shipPhone", "type" => "input" }
  }  

  BILLING_FIELDS = {
    "Name" => { "id" => "billName", "type" => "input" },
    "Address" => { "id" => "billAddress", "type" => "input" },
    "City" => { "id" => "billCity", "type" => "input" },
    "State" => { "id" => "billState", "type" => "input" },
    "Zip" => { "id" => "billZipCode", "type" => "input" },
    "Phone" => { "id" => "billPhone", "type" => "input" },
    "E-mail" => { "id" => "billEmail", "type" => "input" },
    "Credit Card" => { "id" => "CardType", "type" => "combo_box" },
    "Card Number" => { "id" => "CardNumber", "type" => "input" },
    "Expiration" => { "id" => "CardDate", "type" => "input" }
  }

  def fill_shipping_info(table)
    fill_in_fields(table, SHIPPING_FIELDS)
  end

  def fill_billing_info(table)
    fill_in_fields(table, BILLING_FIELDS)
  end

  def verify_shipping_data(table)
    start_row = 2
    path_template = '//body//form//table//tr[2]//td[3]//table//tr[%s]//td[%s]//input'
    compare_fields_with_table(table, start_row, COLUMNS_SHIPPING, path_template)
  end
  
  def check_same_as_bill
    check 'shipSameAsBill'
  end
end