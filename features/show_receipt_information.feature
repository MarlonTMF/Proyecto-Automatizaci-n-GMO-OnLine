Feature: Show receipt Information
  As an online shopper,
  I want to review my billing information,
  so that I can ensure my details are correct before completing my purchase.

  Background:
    Given I am on the GMO Home Page
    And I click on the "Enter GMO OnLine" button
    And I enter the order quantities as show below:
        | Product Name                | Quantity |
        | 3 Person Dome Tent          | 10       |
    And I click on the "Place An Order" button
    And I click on the "Proceed With Order" button

  Scenario Outline: Show billing information on the receipt
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
    Then I should see the following billing information on the receipt:
      | Name            | <Name>            |
      | Postal Address  | <Postal Address>  | 
    And I click for return on the "Return to Home Page" button
    
    Examples:
    | Name     | Address        | City | State | Zip   | Phone        | E-mail             | Card Number        | Expiration | Postal Address     |
    | Walter   | Av. Blanco Galindo | Cbba | Cbba  | 59111 | 777-123-4567 | walter@mail.com    | 1234-567890-11111  | 03/26      | Cbba, Cbba 59111 |
    | Marlon   | Av. Pirai       | Cbba | Cbba  | 59112 | 777-234-5678 | marlon@mail.com    | 1234-567890-22222  | 06/27      | Cbba, Cbba 59112 |
    | Fernando | Av. America     | Cbba | Cbba  | 59113 | 777-345-6789 | fernando@mail.com  | 1234-567890-33333  | 09/28      | Cbba, Cbba 59113 |
    
  Scenario Outline: Show shipping information on the receipt
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
    Then I should see the following shipping information on the receipt:
      | Name            | <Name>            |
      | Phone           | <Phone>           |
      | Postal Address  | <Postal Address>  | 
    And I click for return on the "Return to Home Page" button
    Examples:
    | Name     | Address        | City | State | Zip   | Phone        | E-mail             | Card Number        | Expiration | Postal Address     |
    | Walter   | Av. Blanco Galindo | Cbba | Cbba  | 59111 | 777-123-4567 | walter@mail.com    | 1234-567890-11111  | 03/26      | Cbba, Cbba 59111 |
    | Marlon   | Av. Pirai       | Cbba | Cbba  | 59112 | 777-234-5678 | marlon@mail.com    | 1234-567890-22222  | 06/27      | Cbba, Cbba 59112 |
    | Fernando | Av. America     | Cbba | Cbba  | 59113 | 777-345-6789 | fernando@mail.com  | 1234-567890-33333  | 09/28      | Cbba, Cbba 59113 |