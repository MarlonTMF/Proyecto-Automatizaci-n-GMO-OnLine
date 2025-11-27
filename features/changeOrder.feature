Feature: Change Order
  As an online shopper,
  I want to place an order,
  so that I can change my purchase.

  Background:
    Given I am on the GMO Home Page
    And I click on the "Enter GMO OnLine" button
    And I enter the order quantities as show below:
      | Product Name              | Quantity |
      | 3 Person Dome Tent        | 6        |
      | External Frame Backpack   | 2        |

  Scenario:  Change product quantities in my order
    Given I am at "OnLine Catalog" Page
    And I click on the "Place An Order" button
    And I go back to the previous page
    And I change the order quantities as shown below:
      | Product Name              | New Quantity |
      | 3 Person Dome Tent        | 10           |
      | External Frame Backpack   | 4            |
    When I click on the "Place An Order" button
    Then I should see the updated quantities:
      | Product Description       | Qty | 
      | 3 Person Dome Tent        | 10  | 
      | External Frame Backpack   | 4   | 