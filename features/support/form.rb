require 'capybara/dsl'
require 'rspec/expectations'

class Form
  include RSpec::Matchers
  include Capybara::DSL

  ORDER_QUANTITIES_FIELDS = {
    "3 Person Dome Tent" => { "id" => "QTY_TENTS", "type" => "input" }
  }

  BILLING_FIELDS = {
    "Name" => { "id" => "billName", "type" => "input" },
    "Address" => { "id" => "billAddress", "type" => "input" },
    "City" => { "id" => "billCity", "type" => "input" },
    "State" => { "id" => "billState", "type" => "input" },
    "Zip" => { "id" => "billZipCode", "type" => "input" },
    "Phone" => { "id" => "billPhone", "type" => "input" },
    "E-mail" => { "id" => "billEmail", "type" => "input" },
    "Credit Card" => { "id" => "CardType", "type" => "combo_box" },
    "Card Number" => { "id" => "CardNumber", "type" => "input" },
    "Expiration" => { "id" => "CardDate", "type" => "input" }
  }

  RECEIPT_BILLING_COLUMNS = {
    "Name" => [1, 2],           # Fila 1, Columna 2
    "Postal Address" => [3, 2]  # Fila 3, Columna 2 (City, State, Zip combinados)
  }

  RECEIPT_SHIPPING_COLUMNS = {
    "Name" => [1, 5],           # Fila 1, Columna 5  
    "Phone" => [4, 5],          # Fila 4, Columna 5
    "Postal Address" => [3, 5]  # Fila 3, Columna 5 (City, State, Zip combinados)
  }

  RECEIPT_AMOUNT_COLUMNS_XPATH = {
  # Nota: Se añade '/strong' a Grand Total para extraer el texto correctamente.
  "Product Total"       => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[3]/td[3]",
  "Sales Tax"           => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[4]/td[2]",
  "Shipping & Handling" => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[5]/td[2]",
  "Grand Total"         => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[6]/td[2]/strong" 
}

# CONSTANTES PARA DETALLES DEL PRODUCTO (Fila de la Carpa)
  RECEIPT_PRODUCT_DETAILS_XPATH = {
  "Quantity"          => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[2]/td[1]",
  "Product Description" => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[2]/td[2]/a/strong",
  "Delivery Status"     => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[2]/td[3]",
  "Unit Price"          => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[2]/td[4]",
  "Total Price"         => "/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr/td/div/center/table/tbody/tr[2]/td[5]"
}

  # Función para limpiar el formato de moneda y convertir a float (para robustez)
  def clean_currency_format(value)
    value.gsub(/[\$\s,]/, '').to_f.round(2)
  end
  # --- MÉTODOS DE INTERACCIÓN ---
  def fill_field(identifier, type, value)
    case type
    when "input"
      fill_in identifier, with: value
    when "combo_box"
      select value, from: identifier
    end
  end

  def fill_in_fields(table, fields)
    table.raw.each do |row|
      field_name, field_value = row
      if fields.has_key?(field_name) 
        identifier = fields[field_name]["id"]
        type = fields[field_name]["type"]
        fill_field(identifier, type, field_value)
      end
    end
  end
  # --- MÉTODOS DE COMPARACIÓN (DIRECCIONES) ---
    
  def compare_fields_with_table(table, billing_columns, shipping_columns, path_table)
      puts " DEBUG: Comparando tabla combinada"

      table.hashes.each do |row|
        section = row["Section"]
        field_name = row["Field"]
        field_value = row["Expected Value"]
        
        # Selecciona el conjunto de mapeos de columnas
        columns = case section
                  when "Billing" then billing_columns
                  when "Shipping" then shipping_columns
                  else
                    puts " Advertencia: Sección '#{section}' no reconocida."
                    next
                  end

        if columns.has_key?(field_name)
          row_index, col_index = columns[field_name]
          xpath = path_table % [row_index, col_index]
          puts " DEBUG: Buscando #{section} - #{field_name} en XPath: #{xpath}"

          element = find(:xpath, xpath)
          data = element.text.empty? ? element.value : element.text

          puts " DEBUG: Esperado: '#{field_value}', Encontrado: '#{data}'"
          expect(data).to eq(field_value)
        end
      end
  end

  # --- MÉTODOS DE COMPARACIÓN (MONTOS ROBUSTOS) ---

def compare_amount_fields_robust(table, columns_xpath, scenario_context = {})
  puts " DEBUG: Comparando montos de la orden de forma robusta usando XPaths directos"
  puts " DEBUG: Contexto del escenario: #{scenario_context}" if scenario_context.any?
  
  table.raw.each do |row|
    field_name, expected_value_str = row
    
    # Reemplazar variables del escenario
    if scenario_context.any?
      scenario_context.each do |key, value|
        expected_value_str = expected_value_str.gsub("<#{key}>", value.to_s)
      end
    end
    
    if columns_xpath.has_key?(field_name)
      xpath = columns_xpath[field_name] 
      
      element = find(:xpath, xpath)
      actual_value_str = element.text.strip
      
      actual_value_f = clean_currency_format(actual_value_str)
      expected_value_f = clean_currency_format(expected_value_str)
      
      puts " DEBUG: Buscando #{field_name}. Esperado: #{expected_value_f}, Encontrado: #{actual_value_f} (XPath: #{xpath})"
      
      expect(actual_value_f).to eq(expected_value_f), 
        "Error en #{field_name}: Valores numéricos no coinciden. Esperado: #{expected_value_f}, Encontrado: #{actual_value_f} (Texto encontrado: '#{actual_value_str}')"
    end
  end
end

# --- MÉTODOS DE COMPARACIÓN (DETALLES DEL PRODUCTO) ---

def compare_product_details(table, columns_xpath, scenario_context = {})
  puts " DEBUG: Comparando detalles de producto usando XPaths directos"
  puts " DEBUG: Contexto del escenario: #{scenario_context}" if scenario_context.any?
  
  table.raw.each do |row|
    field_name, expected_value_str = row
    
    # Reemplazar variables del escenario (como <Quantity>, <TotalPrice>)
    if scenario_context.any?
      scenario_context.each do |key, value|
        expected_value_str = expected_value_str.gsub("<#{key}>", value.to_s)
      end
    end
    
    if columns_xpath.has_key?(field_name)
      xpath = columns_xpath[field_name]
      
      element = find(:xpath, xpath)
      actual_value_str = element.text.strip
            
      puts " DEBUG: Buscando #{field_name}. Esperado: '#{expected_value_str}', Encontrado: '#{actual_value_str}' (XPath: #{xpath})"
      
      expect(actual_value_str).to eq(expected_value_str), 
        "Error en #{field_name}: Los valores no coinciden. Esperado: '#{expected_value_str}', Encontrado: '#{actual_value_str}'"
    end
  end
end

    # En form.rb, añade:
  def debug_receipt_structure
    puts "=" * 60
    puts " DEBUG: Analizando estructura del receipt"
    puts "=" * 60
    
    # Intentar diferentes XPath comunes
    test_xpaths = [
      "//table//td[contains(text(), 'Bill to:')]",
      "//table//td[contains(text(), 'Ship to:')]",
      "//table//tr",
      "//table//td"
    ]
    
    test_xpaths.each_with_index do |xpath, i|
      puts "\n🔍 XPath #{i+1}: #{xpath}"
      elements = all(:xpath, xpath, minimum: 0)
      puts "   Encontrados: #{elements.count} elementos"
      
      elements.first(3).each_with_index do |el, idx|
        puts "   [#{idx}] '#{el.text.strip}'"
      end if elements.any?
    end
    
    # También mostrar todo el HTML de tablas
    puts "\n📋 Todas las tablas en la página:"
    all('table').each_with_index do |table, idx|
      puts "\nTabla #{idx + 1}:"
      puts table['outerHTML'][0..500]  # Primeros 500 caracteres
    end
  end

end