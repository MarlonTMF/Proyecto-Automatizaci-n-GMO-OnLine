
COLUMNS_SHIPPING = {
  "Name" => 2,
  "Address" => 2,   
  "City" => 2,
  "State" => 2,     
  "Zip" => 2,    
  "Phone" => 2  
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
