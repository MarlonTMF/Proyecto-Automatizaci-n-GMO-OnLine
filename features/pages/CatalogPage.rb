require_relative 'Form'

class CatalogPage < Form
  PRODUCT_MAPPING = {
    "3 Person Dome Tent"      => { "id" => "QTY_TENTS", "type" => "input" },
    "External Frame Backpack" => { "id" => "QTY_BACKPACKS", "type" => "input" },
    "Glacier Sun Glasses"     => { "id" => "QTY_GLASSES", "type" => "input" },
    "Padded Socks"            => { "id" => "QTY_SOCKS", "type" => "input" },
    "Hiking Boots"            => { "id" => "QTY_BOOTS", "type" => "input" },
    "Back Country Shorts"     => { "id" => "QTY_SHORTS", "type" => "input" }
  }

  SUMMARY_MAPPING = {
    "3 Person Dome Tent"      => 1, 
    "External Frame Backpack" => 1,
    "Glacier Sun Glasses"     => 1
  }

  def visit_home
    visit '/'
    expect(page).to have_content('Welcome to Green Mountain Outpost')
  end

  def click_enter_gmo
    click_button 'bSubmit' 
  end

  def enter_quantities(table)
    fill_in_fields(table, PRODUCT_MAPPING)
  end

  def click_place_order
    click_button 'bSubmit'
  end
  
  def get_alert_message
    page.driver.browser.switch_to.alert.text
  end

  def accept_alert_popup
    page.driver.browser.switch_to.alert.accept
  end
  def go_back
    page.go_back
  end

  def verify_page_content(text)
    expect(page).to have_content(text)
  end
end