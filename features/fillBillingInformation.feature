Feature: Fill in billing information
  As an online shopper,
  I want to Fill in my billing information,
  so that I could complete my purchase.

  Background:
    Given I am on the GMO Home Page
    And I click on the "Enter GMO OnLine" button
    And I enter the order quantities as show below:
        | Product Name                | Quantity |
        | 3 Person Dome Tent          | 10       |
    And I click on the "Place An Order" button
    And I click on the "Proceed With Order" button

  # 1. Escenario POSITIVO - Todo correcto
  Scenario: Fill in my billing information with valid data
    Given I am at "Billing Information" Page
    When I enter the bill to information as shown below:
      | Name        | Pepito Perez     |
      | Address     | Cala cala        |
      | City        | Cochabamba       |
      | State       | Cochabamba       |
      | Zip         | 33126            |
      | Phone       | 123-123-1234     |
      | E-mail      | pepito@gmail.com |
      | Credit Card | American Express |
      | Card Number | 1234-123456-12345|
      | Expiration  | 12/28            |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I am at "OnLine Store Receipt" Page

  # 2. Escenario NEGATIVO - Campo requerido faltante
  Scenario: Fill in my billing information with missing name
    Given I am at "Billing Information" Page
    When I enter the bill to information as shown below:
      | Name        |                  |
      | Address     | Cala cala        |
      | City        | Cochabamba       |
      | State       | Cochabamba       |
      | Zip         | 33126            |
      | Phone       | 123-123-1234     |
      | E-mail      | pepito@gmail.com |
      | Credit Card | American Express |
      | Card Number | 1234-123456-12345|
      | Expiration  | 12/28            |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I should see the following message "This is a required field."