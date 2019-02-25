require_relative '../utils/strings.rb'


class InitializeCommand < MoreUtils
    class << self

        def run *args
            # Add Initializers
            cors_template = get_file_str("#{this_dir}/../templates/rack_cors_initializer.txt")
            write_file("#{root}/config/initializers/rack_cors.rb", cors_template)

            adi_template = get_file_str("#{this_dir}/../templates/api_documentation_initializer.txt")
            write_file("#{root}/config/initializers/api_documentation_js.rb", adi_template)

            # Add Controllers
            dc_template = get_file_str("#{this_dir}/../templates/documentation_controller.txt")
            write_file("#{root}/app/contorllers/documentation_controller.rb", dc_template)

            gc_template = get_file_str("#{this_dir}/../templates/global_controller.txt")
            write_file("#{root}/app/contorllers/global_controller.rb", gc_template)

            # Add Concerns
            ehc_template = get_file_str("#{this_dir}/../templates/exception_handler.txt")
            write_file("#{root}/app/contorllers/concerns/exception_handler.rb", ehc_template)

            resp_template = get_file_str("#{this_dir}/../templates/response.txt")
            write_file("#{root}/app/contorllers/concerns/response.rb", resp_template)

            # Add Views
            exec("mkdir -p #{root}/app/views/documentation")
            dihtml_template = get_file_str("#{this_dir}/../templates/documentation.index.erb.txt")
            write_file("#{root}/app/views/documenation/documentation.index.erb", dihtml_template)

            dlhtml_template = get_file_str("#{this_dir}/../templates/documentation.layout.erb.txt")
            write_file("#{root}/app/views/layouts/documentation.layout.erb", dlhtml_template)
            
            # Update Routes
            routes_template = get_file_str("#{this_dir}/../templates/routes_documentation.txt")
            routes_file = get_file_str("#{root}/config/routes.rb")
            routes_arr = routes_file.split("\n")
            last_end_line = last_end_index(routes_arr)
            insert_index = last_end_line - 1

            routes_arr.slice(insert_index).join("\n") + "\n#{routes_template}\nend\n"
        end

        def last_end_index arr
            index = 0
            arr.each_with_index do |e, i|
                index = i if /end/.match(e)
            end
            index
        end

    end

end
  
