class InitializeCommand
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
            system("mkdir -p #{root}/app/views/documenation")
            dihtml_template = get_file_str("#{this_dir}/../templates/documentation.index.erb.txt")
            write_file("#{root}/app/views/documenation/documentation.index.erb", dihtml_template)

            dlhtml_template = get_file_str("#{this_dir}/../templates/documentation.layout.erb.txt")
            write_file("#{root}/app/views/layouts/documentation.layout.erb", dlhtml_template)
            
            # Update Routes
        end

    end

    def get_file_str path
        File.open(path, 'r:UTF-8', &:read)
    end

    def write_file path, str
        File.write(path, str)
    end

    def this_dir
        __dir__
    end

    def root
        Dir.pwd
    end
end
  
