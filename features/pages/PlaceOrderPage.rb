require_relative 'Form'

class PlaceOrderPage < Form
  
  SUMMARY_MAPPING = {
    "3 Person Dome Tent"      => 1, 
    "External Frame Backpack" => 1,
    "Glacier Sun Glasses"     => 1,
    "Padded Socks"            => 1,
    "Hiking Boots"            => 1,
    "Back Country Shorts"     => 1,
    "Product Total"           => 1,
    "Sales Tax"               => 1,
    "Shipping & Handling"     => 1,
    "Grand Total"             => 1,
    "Gran Total"              => 1 
  }

  def verify_order_details(table)
    validate_rows_by_text(table)
  end
end