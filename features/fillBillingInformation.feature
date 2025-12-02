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
  

  
  # ESCENARIO 1-3: Pruebas POSITIVAS con diferentes tarjetas
  # Objetivo: Verificar que se puede completar una compra
  # con diferentes tipos de tarjetas de crédito válidas
  Scenario Outline: Fill in my billing information with different card types
    Given I am at "Billing Information" Page
    When I enter the bill to information as shown below:
      | Name        | <Name>           |
      | Address     | <Address>        |
      | City        | <City>           |
      | State       | <State>          |
      | Zip         | <Zip>            |
      | Phone       | <Phone>          |
      | E-mail      | <E-mail>         |
      | Credit Card | <Credit Card>    |
      | Card Number | <Card Number>    |
      | Expiration  | <Expiration>     |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I am at "OnLine Store Receipt" Page
    Examples:
    | Name   | Address    | City | State| Zip   | Phone        | E-mail           | Credit Card      | Card Number        | Expiration  |
    | Pepito | Cala cala  | Cbba | Cbba | 33126 | 123-123-1234 | pepito@gmail.com | American Express | 1234-123456-12345  | 12/27       |
    | Maria  | 3er anillo | Scz  | Scz  | 65432 | 456-789-0123 | maria@gmail.com  | Visa             | 1234-1234-1234-1234| 01/28       |
    | Ana    | Zona Sur   | Cbba | Cbba | 98765 | 321-654-9870 | ana@gmail.com    | MasterCard       | 1234-1234-1234-1234| 12/28       |

  
  # ESCENARIO 4-12: Pruebas de CAMPOS REQUERIDOS
  # Objetivo: Verificar que la aplicación valida campos obligatorios
  # Cada prueba deja un campo diferente vacío
  Scenario Outline: Fill in my billing information with missing fields
    Given I am at "Billing Information" Page
    When I enter the bill to information as shown below:
      | Name        | <Name>           |
      | Address     | <Address>        |
      | City        | <City>           |
      | State       | <State>          |
      | Zip         | <Zip>            |
      | Phone       | <Phone>          |
      | E-mail      | <E-mail>         |
      | Credit Card | <Credit Card>    |
      | Card Number | <Card Number>    |
      | Expiration  | <Expiration>     |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I should see the following message "<Expected Message>"
    Examples:
    # 4. Campo Name vacío
    | Name   | Address    | City | State| Zip   | Phone        | E-mail           | Credit Card      | Card Number        | Expiration  | Expected Message |
    |        | Cala cala  | Cbba | Cbba | 33126 | 123-123-1234 | pepito@gmail.com | American Express | 1234-123456-12345  | 12/27       | This is a required field. |
    
    # 5. Campo Address vacío
    | Pepito |            | Cbba | Cbba | 33126 | 123-123-1234 | pepito@gmail.com | American Express | 1234-123456-12345  | 12/27       | This is a required field. |
    
    # 6. Campo City vacío
    | Pepito | Cala cala  |      | Cbba | 33126 | 123-123-1234 | pepito@gmail.com | American Express | 1234-123456-12345  | 12/27       | This is a required field. |
    
    # 7. Campo State vacío
    | Pepito | Cala cala  | Cbba |      | 33126 | 123-123-1234 | pepito@gmail.com | American Express | 1234-123456-12345  | 12/27       | This is a required field. |
    
    # 8. Campo Zip vacío - muestra validación específica
    | Pepito | Cala cala  | Cbba | Cbba |       | 123-123-1234 | pepito@gmail.com | American Express | 1234-123456-12345  | 12/27       | Please enter a valid zip code in this field. |
    
    # 9. Campo Phone vacío - muestra validación específica
    | Pepito | Cala cala  | Cbba | Cbba | 33126 |              | pepito@gmail.com | American Express | 1234-123456-12345  | 12/27       | Please enter a valid phone number in this field. |
    
    # 11. Campo Card Number vacío - muestra validación específica
    | Pepito | Cala cala  | Cbba | Cbba | 33126 | 123-123-1234 | pepito@gmail.com | American Express |                    | 12/27       | Please enter a valid card number of the form '1234-123456-12345' in this field. |
    
    # 12. Campo Expiration vacío - muestra validación específica
    | Pepito | Cala cala  | Cbba | Cbba | 33126 | 123-123-1234 | pepito@gmail.com | American Express | 1234-123456-12345  |             | Please enter a valid date of the form 'MM/YY' in this field. |

  # ESCENARIO 13: Validación de ZIP CODE inválido
  # Objetivo: Verificar que no acepta códigos postales inválidos
  # ZIP = 0 (debe ser de 5 dígitos)
  Scenario: Fill in my billing information with a wrong zip code
    Given I am at "Billing Information" Page
    When I enter the bill to information as shown below:
      | Name        | Pepito Perez     |
      | Address     | Cala cala        |
      | City        | Cochabamba       |
      | State       | Cochabamba       |
      | Zip         | 0                |
      | Phone       | 123-123-1234     |
      | E-mail      | pepito@gmail.com |
      | Credit Card | American Express |
      | Card Number | 1234-123456-12345|
      | Expiration  | 12/27            |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I should see the following message "Please enter a valid zip code in this field."

  # ESCENARIO 14: Validación de PHONE NUMBER inválido
  # Objetivo: Verificar que no acepta formatos de teléfono incorrectos
  # Phone = 123 (debe ser formato ###-###-####)
  Scenario: Fill in my billing information with a wrong phone number
    Given I am at "Billing Information" Page
    When I enter the bill to information as shown below:
      | Name        | Pepito Perez     |
      | Address     | Cala cala        |
      | City        | Cochabamba       |
      | State       | Cochabamba       |
      | Zip         | 33126            |
      | Phone       | 123              |
      | E-mail      | pepito@gmail.com |
      | Credit Card | American Express |
      | Card Number | 1234-123456-12345|
      | Expiration  | 12/27            |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I should see the following message "Please enter a valid phone number in this field."

  # ESCENARIO 15: Validación de CARD NUMBER MasterCard
  # Objetivo: Verificar validación específica para MasterCard
  # Card Number = 1234 (debe ser ####-####-####-####)
  Scenario: Fill in my billing information with a wrong card number for Master Card
    Given I am at "Billing Information" Page
    When I enter the bill to information as shown below:
      | Name        | Pepito Perez     |
      | Address     | Cala cala        |
      | City        | Cochabamba       |
      | State       | Cochabamba       |
      | Zip         | 33126            |
      | Phone       | 123-123-1234     |
      | E-mail      | pepito@gmail.com |
      | Credit Card | MasterCard       |
      | Card Number | 1234             |
      | Expiration  | 12/27            |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I should see the following message "Please enter a valid card number of the form '1234-1234-1234-1234' in this field."
  
  # ESCENARIO 16: Validación de CARD NUMBER Visa
  # Objetivo: Verificar validación específica para Visa
  # Card Number = 1234 (debe ser ####-####-####-####)
  Scenario: Fill in my billing information with a wrong card number for Visa
    Given I am at "Billing Information" Page
    When I enter the bill to information as shown below:
      | Name        | Pepito Perez     |
      | Address     | Cala cala        |
      | City        | Cochabamba       |
      | State       | Cochabamba       |
      | Zip         | 33126            |
      | Phone       | 123-123-1234     |
      | E-mail      | pepito@gmail.com |
      | Credit Card | Visa             |
      | Card Number | 1234             |
      | Expiration  | 12/27            |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I should see the following message "Please enter a valid card number of the form '1234-1234-1234-1234' in this field."

  # ESCENARIO 17: Validación de CARD NUMBER American Express
  # Objetivo: Verificar validación específica para American Express
  # Card Number = 1234 (debe ser ####-######-#####)
  Scenario: Fill in my billing information with a wrong card number for American Express
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
      | Card Number | 1234             |
      | Expiration  | 12/27            |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I should see the following message "Please enter a valid card number of the form '1234-123456-12345' in this field."

  # ESCENARIO 17: Validación de EXPIRATION DATE
  # Objetivo: Verificar que no acepta formato de fecha incorrecto
  # Expiration = 12/2024 (debe ser MM/YY)
  Scenario: Fill in my billing information with a wrong Expiration Date Card
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
      | Expiration  | 12/2024          |
    And I check the "shipSameAsBill" checkbox
    And I click on the "Place The Order" button
    Then I should see the following message "Please enter a valid date of the form 'MM/YY' in this field."