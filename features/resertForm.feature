Feature: Reset form fields
  As an online shopper,
  I want to reset the form,
  So that I can clear my selection and start over without reloading.

  Background:
    Given I am on the GMO Home Page
    And I click on the "Enter GMO OnLine" button

  Scenario: Resetting Form After Filling Fields
    When I enter the order quantities as shown below:
      | Product Name            | Quantity |
      | 3 Person Dome Tent      | 6        |
      | External Frame Backpack | 2        |
      | Glacier Sun Glasses     | 8        |
      | Padded Socks            | 9        |
      | Hiking Boots            | 3        |
      | Back Country Shorts     | 2        |
    And I click on the "Reset Form" button
    Then I should see the following fields reset to default:
      | Product Name            | Quantity |
      | 3 Person Dome Tent      | 0        |
      | External Frame Backpack | 0        |
      | Glacier Sun Glasses     | 0        |
      | Padded Socks            | 0        |
      | Hiking Boots            | 0        |
      | Back Country Shorts     | 0        |