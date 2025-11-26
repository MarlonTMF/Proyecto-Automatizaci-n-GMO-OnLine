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
      field_name, field_value = row
      if fields_mapping.has_key?(field_name)
        config = fields_mapping[field_name]
        fill_field(config["id"], config["type"], field_value)
      end
    end
  end

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
end