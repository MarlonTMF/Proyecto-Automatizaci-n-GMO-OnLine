require 'capybara/dsl'
require 'rspec/expectations'

class Form
  include Capybara::DSL
  
  def fill_in_fields(table, fields)
    table.raw.each do |row|
      field_name, field_value = row
      if fields.has_key?(field_name) 
        field_config = fields[field_name]
        identifier = field_config["id"]
        type = field_config["type"]
        
        case type
        when "input"
          fill_in identifier, with: field_value
        when "combo_box"
          select field_value, from: identifier
        end
      end
    end
  end
  
  def compare_fields_with_table(table, start_row, columns, path_template)
    table.raw.each_with_index do |row, index|
      field_name, expected_value = row
      
      if columns.has_key?(field_name)
        row_index = start_row + index
        column_index = columns[field_name]
        
        xpath = path_template % [row_index, column_index]
        actual_value = find(:xpath, xpath).value
        
        expect(actual_value).to eq(expected_value)
      end
    end
  end
end