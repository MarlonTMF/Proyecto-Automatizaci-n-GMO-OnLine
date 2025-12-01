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
end