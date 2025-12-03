require 'net/http'


# Cerrar solo al final de toda la suite o por etiqueta
After do |scenario|
  # Solo cerrar si el escenario falló o tiene etiqueta @reset
  if scenario.failed? || scenario.source_tag_names.include?('@reset')
    Capybara.current_session.driver.quit
  end
end

Before '@maximize' do
  page.driver.browser.manage.window.maximize
end

Before do
  unless internet_available?
    raise 'No hay conexión a Internet. Deteniendo pruebas.'
  end
end

def internet_available?
    return false unless Capybara.app_host
  begin
    uri = URI(Capybara.app_host)
    response = Net::HTTP.get_response(uri)
    response.is_a?(Net::HTTPSuccess) || response.is_a?(Net::HTTPRedirection)
  rescue SocketError, Errno::ECONNREFUSED
    false
  end
end

AfterStep('@slow') do
  sleep 1.5
end

AfterStep('@debug') do |result, step|
  puts "Completado paso: #{step.text}"
end

# features/support/scenario_outline_helper.rb

module ScenarioOutlineHelper
  # Hook para capturar las variables del Scenario Outline
  Before do |scenario|
    # Inicializar el hash de variables
    @scenario_variables = {}
    
    # Si es un Scenario Outline, Cucumber ya reemplazó las variables en el texto
    # Pero necesitamos capturarlas para usarlas en las tablas
    if scenario.respond_to?(:scenario_outline)
      # Este es el approach más directo
      # Buscamos variables en el título del scenario
      scenario.name.scan(/<([^>]+)>/).flatten.each do |var_name|
        @scenario_variables[var_name] = nil  # Placeholder
      end
    end
  end
end

World(ScenarioOutlineHelper)