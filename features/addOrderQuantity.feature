Feature: Add Order Quantity
  As an online shopper,
  I want to add product quantities to my order,
  So that I can complete my purchase.
  
  Background:
    Given I am on the GMO Home Page
    And I click on the "Enter GMO OnLine" button

  Scenario: Add Order quantities for products
    When I enter the order quantities as show below:
      | Product Name            | Quantity |
      | 3 Person Dome Tent      | 8        |
      | External Frame Backpack | 9        |
      | Glacier Sun Glasses     | 10       |
      
    And I click on the "Place An Order" button
    Then I should see the following quantities:
      | Product Description     | Qty | 
      | 3 Person Dome Tent      | 8   | 
      | External Frame Backpack | 9   | 
      | Glacier Sun Glasses     | 10  | 
      
  Scenario: Leave Order quantities empty
    When I remove the order quantities as show below:
      | Product Name            | Quantity |
      | 3 Person Dome Tent      | blank    |
      | External Frame Backpack | blank    |
      | Glacier Sun Glasses     | blank    |
      | Padded Socks            | blank    |
    And I click on the "Place An Order" button
    Then I should see the following message "Please Order Something First"
  @quit
  Scenario: Add Order quantities with letters
    When I enter the order quantities as shown below:
      | Product Name            | Quantity  |
      | 3 Person Dome Tent      | Cuatro    |
    And I click on the "Place An Order" button
    Then I should see the following message "Please enter only digits in this field."