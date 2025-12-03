Feature: Show receipt Information
  As an online shopper,
  I want to see a detailed order receipt after purchase,
  so that I can verify all charges and keep accurate  records.

  Background:
    Given I am on the GMO Home Page
    And I click on the "Enter GMO OnLine" button
    And I enter the order quantities as show below:
        | Product Name                | Quantity |
        | 3 Person Dome Tent          | 9       |
    And I click on the "Place An Order" button
    And I click on the "Proceed With Order" button

  Scenario Outline: Show all billing and shipping information on the receipt
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
      | Product Total | $ 2699.91 |
      | Sales Tax | $ 135.00 |
      | Shipping & Handling | $ 5.00 |
      | Grand Total | $ 2839.91 |

    And I should see the correct product details on the receipt:
      | Field | Expected Value |
      | Quantity | 9 |
      | Product Description | 3 Person Dome Tent |
      | Delivery Status | To Be Shipped |
      | Unit Price | $ 299.99 |
      | Total Price | $ 2699.91 |

    And I click for return on the "Return to Home Page" button
    
    Examples:
    | Name     | Address        | City | State | Zip   | Phone        | E-mail             | Card Number        | Expiration | Postal Address     |
    | Walter   | Av. Blanco Galindo | Cbba | Cbba  | 59111 | 777-123-4567 | walter@mail.com    | 1234-567890-11111  | 03/26      | Cbba, Cbba 59111 |
    | Marlon   | Av. Pirai       | Cbba | Cbba  | 59112 | 777-234-5678 | marlon@mail.com    | 1234-567890-22222  | 06/27      | Cbba, Cbba 59112 |
    | Fernando | Av. America     | Cbba | Cbba  | 59113 | 777-345-6789 | fernando@mail.com  | 1234-567890-33333  | 09/28      | Cbba, Cbba 59113 |
    
