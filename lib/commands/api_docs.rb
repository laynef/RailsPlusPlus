require_relative '../utils/strings.rb'


class ApiDocsCommand < MoreUtils
  class << self

    def run(*args)
      lookup = flag_lookup(args)

      version = versions(lookup)
      return version if !version
      
      # Add Initializers
      doc_str = version == 6 ? '/../javascripts/documentation.js' : version == 5 ? '/../assets/javascripts/documentation.js' : ''
      adi_template = get_file_str("#{this_dir}/../templates/api_documentation_initializer.txt")
      adi_template = adi_template.gsub('{{ DOC_PATH }}', doc_str)
      write_file("#{root}/config/initializers/api_documentation_js.rb", adi_template)

      # Add Controllers
      dc_template = get_file_str("#{this_dir}/../templates/documentation_controller.txt")
      write_file("#{root}/app/controllers/documentation_controller.rb", dc_template)

      # Add Service
      system("mkdir -p #{root}/app/services")
      aps_template = get_file_str("#{this_dir}/../templates/api_documentation_service.txt")
      write_file("#{root}/app/services/api_documentation_service.rb", aps_template)

      # Add Views
      system("mkdir -p #{root}/app/views/documentation")
      dihtml_template = get_file_str("#{this_dir}/../templates/documentation.index.erb.txt")
      write_file("#{root}/app/views/documentation/index.html.erb", dihtml_template)

      dlhtml_template = get_file_str("#{this_dir}/../templates/documentation.layout.erb.txt")
      write_file("#{root}/app/views/layouts/documentation.html.erb", dlhtml_template)

      # Add Routes
      routes_template = get_file_str("#{this_dir}/../templates/routes_documentation.txt")
      routes_file = get_file_str("#{root}/config/routes.rb")
      routes_arr = routes_file.split("\n")
      last_end_line = last_end_index(routes_arr)
      new_routes = routes_arr.slice(0, last_end_line).join("\n") + "\n#{routes_template}\n" + routes_arr.slice(last_end_line, routes_arr.length).join("\n")
      write_file("#{root}/config/routes.rb", new_routes)
      
      puts "Added Automatic API documentation to your project."
    end

    def last_end_index arr
      arr.each_with_index.inject(0) do |acc, (e, i)|
        acc = i if /(namespace)/.match(e) && acc == 0
        acc
      end
    end

    def wrong_version_error
      puts 'Must provide a version option'
      return nil
    end

  end
end