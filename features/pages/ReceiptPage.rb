require_relative 'Form'

class ReceiptPage < Form

  # --- CONSTANTES ESPECÍFICAS DEL RECIBO ---
  RECEIPT_BILLING_COLUMNS = {
    "Name" => [1, 2],           # Fila 1, Columna 2
    "Postal Address" => [3, 2]  # Fila 3, Columna 2
  }

  RECEIPT_SHIPPING_COLUMNS = {
    "Name" => [1, 5],           
    "Phone" => [4, 5],          
    "Postal Address" => [3, 5]  
  }

  RECEIPT_AMOUNT_COLUMNS_XPATH = {
    "Product Total"       => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[3]/td[3]",
    "Sales Tax"           => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[4]/td[2]",
    "Shipping & Handling" => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[5]/td[2]",
    "Grand Total"         => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[6]/td[2]/strong" 
  }

  RECEIPT_PRODUCT_DETAILS_XPATH = {
    "Quantity"            => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[2]/td[1]",
    "Product Description" => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[2]/td[2]/a/strong",
    "Delivery Status"     => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[2]/td[3]",
    "Unit Price"          => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[2]/td[4]",
    "Total Price"         => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[2]/td[5]"
  }

  # --- MÉTODOS DE VERIFICACIÓN ---
  def verify_billing_shipping_info(table)
    verify_page_loaded # Verificación básica
    path_table = "/html/body/table[2]/tbody/tr[1]/td/div/center/table/tbody/tr[%i]/td[%i]"
    table.hashes.each do |row|
      section = row["Section"]
      field_name = row["Field"]
      expected_value = row["Expected Value"]
      columns = (section == "Billing") ? RECEIPT_BILLING_COLUMNS : RECEIPT_SHIPPING_COLUMNS
      if columns.has_key?(field_name)
        row_idx, col_idx = columns[field_name]
        xpath = path_table % [row_idx, col_idx]
        element = find(:xpath, xpath)
        actual_data = element.text.strip
        expect(actual_data).to eq(expected_value)
      end
    end
  end

  def verify_order_amounts(table, scenario_context = {})
    verify_dynamic_table(table, RECEIPT_AMOUNT_COLUMNS_XPATH, scenario_context, true)
  end

  def verify_product_details(table, scenario_context = {})
    verify_dynamic_table(table, RECEIPT_PRODUCT_DETAILS_XPATH, scenario_context, false)
  end

  def return_to_home
    click_button('Return to Home Page')
  end

  private
  def verify_page_loaded
    expect(page).to have_content('OnLine Store Receipt')
  end

  def verify_dynamic_table(table, xpaths, context, is_currency)
    table.raw.each do |row|
      field_name, expected_raw = row
      if context && context.any?
        context.each do |k, v| 
          expected_raw = expected_raw.gsub("<#{k}>", v.to_s) if expected_raw.include?("<#{k}>")
        end
      end

      if xpaths.has_key?(field_name)
        element = find(:xpath, xpaths[field_name])
        actual_text = element.text.strip

        if is_currency
          expect(clean_currency(actual_text)).to eq(clean_currency(expected_raw))
        else
          expect(actual_text).to eq(expected_raw)
        end
      end
    end
  end

  def clean_currency(value)
    value.gsub(/[\$\s,]/, '').to_f.round(2)
  end
end