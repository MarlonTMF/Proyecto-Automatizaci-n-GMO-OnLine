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

  def compare_fields_with_table(table, columns, path_table)
    puts "🔍 DEBUG: Comparando tabla con columnas: #{columns}"
    
    table.raw.each do |row|
      field_name, field_value = row
      if columns.has_key?(field_name) 
        row_index, col_index = columns[field_name]
        xpath = path_table % [row_index, col_index]
        puts "🔍 DEBUG: Buscando #{field_name} en XPath: #{xpath}"
        
        element = find(:xpath, xpath)
        data = element.text.empty? ? element.value : element.text
        
        puts "🔍 DEBUG: Esperado: '#{field_value}', Encontrado: '#{data}'"
        
        expect(data).to eq(field_value)
      end
    end
  end

  # ✅ REMOVER el método debug_table_structure que causa error
  # (ya no lo necesitamos porque sabemos la estructura)
end