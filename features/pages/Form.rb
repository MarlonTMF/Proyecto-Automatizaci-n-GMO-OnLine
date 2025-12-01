require 'capybara/dsl'
require 'rspec/expectations'

class Form
  include RSpec::Matchers
  include Capybara::DSL

  def fill_field(identifier, type, value)
    case type
    when "input"
      fill_in identifier, with: value
    when "combo_box"
      select value, from: identifier
    when "checkbox"
      if value.to_s.downcase == 'true' || value.to_s.downcase == 'yes'
        check identifier
      else
        uncheck identifier
      end
    else
      raise ArgumentError, "Unsupported field type: #{type}"
    end
  end

  def fill_in_fields(table, fields_mapping)
    data = table.raw 
    data.each do |row|
      field_name, raw_value = row
      final_value = raw_value.to_s.downcase == 'blank' ? "" : raw_value

      if fields_mapping.has_key?(field_name)
        config = fields_mapping[field_name]
        fill_field(config["id"], config["type"], final_value)
      end
    end
  end

  # Validar Textos en Tablas (para Display Order)
  def compare_fields_with_table(table, start_row, columns_mapping, xpath_template)
    data = table.raw
    current_row = start_row

    data.each do |row|
      field_name, expected_value = row
      if columns_mapping.has_key?(field_name)
        col_index = columns_mapping[field_name]
        xpath = xpath_template % [current_row, col_index]
        begin
          element = find(:xpath, xpath)
          actual_data = element.text.empty? ? element.value : element.text
          expect(actual_data).to include(expected_value)
        rescue Capybara::ElementNotFound
          raise "Element not found at row #{current_row} column #{col_index}"
        end
        current_row += 1
      end
    end
  end

  def validate_rows_by_text(table)
    data = table.rows_hash 
    data.each do |key_text, expected_value|
      row_xpath = "//tr[td[contains(., '#{key_text}')]]"
      begin
        row_element = find(:xpath, row_xpath, match: :first)
        expect(row_element.text).to include(expected_value)
      rescue Capybara::ElementNotFound
        raise "No se encontró fila con texto: '#{key_text}'"
      end
    end
  end

  # --- NUEVO: Validar Valores de Inputs (para Reset Form) ---
  def verify_input_values(table, fields_mapping)
    data = table.raw
    data.each do |row|
      field_name, expected_value = row
      
      # Manejo de "blank"
      expected_value = expected_value.to_s.downcase == 'blank' ? "" : expected_value

      if fields_mapping.has_key?(field_name)
        config = fields_mapping[field_name]
        # Buscamos el input por su ID/Name y obtenemos su propiedad .value
        actual_value = find_field(config["id"]).value
        
        expect(actual_value).to eq(expected_value), 
          "Error en #{field_name}: Se esperaba '#{expected_value}' pero se encontró '#{actual_value}'"
      end
    end
  end
end