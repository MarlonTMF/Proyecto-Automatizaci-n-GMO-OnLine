Feature: Smoke Test - Basic Purchase Flow
  As an online shopper,
  I want to verify the basic purchase functionality works correctly with different users,
  so that I can trust the system handles various customer data properly.

  Background:
    Given I am on the GMO Home Page
    And I click on the "Enter GMO OnLine" button
    And I enter the order quantities as show below:
        | Product Name                | Quantity |
        | 3 Person Dome Tent          | 1        |
    And I click on the "Place An Order" button
    And I click on the "Proceed With Order" button

  @smoke @fast
  Scenario Outline: Basic receipt validation with single product
    Given I am at "Billing Information" Page
    When I enter the bill to information as shown below:
      | Name        | <Name>           |
      | Address     | <Address>        |
      | City        | <City>           |
      | State       | <State>          |
      | Zip         | <Zip>            |
      | Phone       | <Phone>          |
      | E-mail      | <E-mail>         |
      | Credit Card | American Express |
      | Card Number | <Card Number>    |
      | Expiration  | <Expiration>     |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I should see the correct billing and shipping information on the receipt:
      | Section           | Field           | Expected Value        |
      | Billing           | Name            | <Name>                |
      | Billing           | Postal Address  | <Postal Address>      |
      | Shipping          | Name            | <Name>                |
      | Shipping          | Phone           | <Phone>               |
      | Shipping          | Postal Address  | <Postal Address>      |
      
    And I should see the correct order amounts on the receipt robustly:
      | Field | Expected Value |
      | Product Total | $ 299.99  |
      | Sales Tax | $ 15.00      |
      | Shipping & Handling | $ 5.00 |
      | Grand Total | $ 319.99   |

    And I should see the correct product details on the receipt:
      | Field | Expected Value |
      | Quantity | 1 |
      | Product Description | 3 Person Dome Tent |
      | Delivery Status | To Be Shipped |
      | Unit Price | $ 299.99 |
      | Total Price | $ 299.99 |

    And I click for return on the "Return to Home Page" button
    
    Examples:
      | Name     | Address   | City  | State | Zip   | Phone        | E-mail          | Card Number       | Expiration | Postal Address |
      | TestUser1| 123 Main St|SmokeCity| SC  | 12345 | 555-111-2222 | test1@test.com  | 1111-2222-3333    | 12/25      | SmokeCity, SC 12345 |
      | TestUser2| 456 Oak Ave|TestTown | TT  | 54321 | 555-333-4444 | test2@test.com  | 4444-5555-6666    | 06/26      | TestTown, TT 54321 |
      | TestUser3| 789 Pine Rd|QuickCity| QC  | 98765 | 555-777-8888 | test3@test.com  | 7777-8888-9999    | 09/27      | QuickCity, QC 98765 |

