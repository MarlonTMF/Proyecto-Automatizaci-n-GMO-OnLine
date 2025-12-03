Feature: Smoke Test - Product Quantity Validation
  As an online shopper,
  I want to verify the system calculates correctly for different quantities,
  so that I know the pricing is accurate.

  Background:
    Given I am on the GMO Home Page
    And I click on the "Enter GMO OnLine" button

  @smoke @quantities
  Scenario Outline: Validate receipt for different quantities
    When I enter the order quantities as show below:
      | Product Name                | Quantity |
      | 3 Person Dome Tent          | <Quantity> |
    And I click on the "Place An Order" button
    And I click on the "Proceed With Order" button
    And I am at "Billing Information" Page
    And I enter the bill to information as shown below:
      | Name        | QtyTest User     |
      | Address     | 123 Qty St       |
      | City        | Qty City         |
      | State       | QC               |
      | Zip         | 12345            |
      | Phone       | 555-123-4567     |
      | E-mail      | qty@test.com     |
      | Credit Card | American Express |
      | Card Number | 1111-2222-3333   |
      | Expiration  | 12/25            |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I should see the correct product details on the receipt:
      | Field | Expected Value |
      | Quantity | <Quantity> |
      | Product Description | 3 Person Dome Tent |
      | Delivery Status | To Be Shipped |
      | Unit Price | $ 299.99 |
      | Total Price | $ <TotalPrice> |
      
    And I should see the correct order amounts on the receipt robustly:
      | Field | Expected Value |
      | Product Total | $ <ProductTotal> |
      | Sales Tax | $ <SalesTax> |
      | Shipping & Handling | $ 5.00 |
      | Grand Total | $ <GrandTotal> |

    And I click for return on the "Return to Home Page" button
    
    Examples:
      | Quantity | TotalPrice | ProductTotal | SalesTax | GrandTotal |
      | 1        | 299.99     | 299.99       | 15.00    | 319.99     |
      | 2        | 599.98     | 599.98       | 30.00    | 634.98     |
      | 5        | 1499.95    | 1499.95      | 75.00    | 1579.95    |
      | 10       | 2999.90    | 2999.90      | 150.00   | 3154.90    |