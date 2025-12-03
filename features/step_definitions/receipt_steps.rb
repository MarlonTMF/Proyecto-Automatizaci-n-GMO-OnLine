# Background Steps
Given(/^I am on the GMO Home Page$/) do
  visit('/')
end

# Step genérico para botones
When(/^I click on the "([^"]*)" button$/) do |button_name|
  click_button(button_name)
end

# Order Quantities
Given(/^I enter the order quantities as show below:$/) do |table|
  @form.fill_in_fields(table, Form::ORDER_QUANTITIES_FIELDS)
end

# Billing Information Steps
Given(/^I am at "([^"]*)" Page$/) do |page_name|
  expect(page).to have_content(page_name)
end

When(/^I enter the bill to information as shown below:$/) do |table|
  @form.fill_in_fields(table, Form::BILLING_FIELDS)
end

When(/^I check the "([^"]*)" checkbox$/) do |checkbox_name|
  check(checkbox_name)
end


Then(/^I should see the correct billing and shipping information on the receipt:$/) do |table|
  @form.debug_receipt_structure if ENV['DEBUG']

  expect(page).to have_content('OnLine Store Receipt')

  path_table = "/html/body/table[2]/tbody/tr[1]/td/div/center/table/tbody/tr[%i]/td[%i]"
  
  # Usamos el método modificado con ambos conjuntos de columnas.
  @form.compare_fields_with_table(
    table,
    Form::RECEIPT_BILLING_COLUMNS,
    Form::RECEIPT_SHIPPING_COLUMNS,
    path_table
  )
end

And(/^I should see the correct order amounts on the receipt robustly:$/) do |table|
  # Procesar la tabla para reemplazar variables
  processed_table = process_table_with_variables(table)
  
  @form.compare_amount_fields_robust(
    processed_table,
    Form::RECEIPT_AMOUNT_COLUMNS_XPATH
  )
end


Then(/^I should see the correct product details on the receipt:$/) do |table|
  # Procesar la tabla para reemplazar variables
  processed_table = process_table_with_variables(table)
  
  @form.compare_product_details(
    processed_table,
    Form::RECEIPT_PRODUCT_DETAILS_XPATH
  )
end


Then(/^I click for return on the "Return to Home Page" button$/) do
  click_button('Return to Home Page')
end

# AÑADE este método helper:
def process_table_with_variables(table)
  # Crear una nueva tabla procesada
  processed_rows = []
  
  table.raw.each do |row|
    processed_row = []
    row.each do |cell|
      if cell.is_a?(String) && cell =~ /<[^>]+>/
        # Es una variable - intentar reemplazarla
        variable_name = cell.match(/<([^>]+)>/)[1]
        
        # Buscar el valor de la variable
        value = find_variable_value(variable_name)
        
        if value
          processed_row << value.to_s
        else
          processed_row << cell  # Dejar como está si no encontramos
        end
      else
        processed_row << cell
      end
    end
    processed_rows << processed_row
  end
  
  # Crear nueva tabla con las filas procesadas
  Cucumber::MultilineArgument::DataTable.new(processed_rows)
end

def find_variable_value(variable_name)
  # Buscar en diferentes lugares
  # 1. En las variables del scenario (si las capturamos)
  return @scenario_variables[variable_name] if @scenario_variables && @scenario_variables[variable_name]
  
  # 2. En variables de instancia (Cucumber las crea automáticamente)
  instance_var_name = "@#{variable_name.downcase}"
  return instance_variable_get(instance_var_name) if instance_variable_defined?(instance_var_name)
  
  # 3. Intentar obtener del ejemplo actual
  if defined?(example_row) && example_row && example_row[variable_name]
    return example_row[variable_name]
  end
  
  nil
end