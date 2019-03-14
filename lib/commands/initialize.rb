require_relative '../utils/strings.rb'


class InitializeCommand < MoreUtils
    class << self

        def run *args
            lookup = flag_lookup(args)

            # Add Initializers
            cors_template = get_file_str("#{this_dir}/../templates/rack_cors_initializer.txt")
            write_file("#{root}/config/initializers/cors.rb", cors_template)

            # Add Controllers
            gc_template = get_file_str("#{this_dir}/../templates/global_controller.txt")
            write_file("#{root}/app/controllers/global_controller.rb", gc_template)

            # Add Concerns
            ehc_template = get_file_str("#{this_dir}/../templates/exception_handler.txt")
            write_file("#{root}/app/controllers/concerns/exception_handler.rb", ehc_template)

            resp_template = get_file_str("#{this_dir}/../templates/response.txt")
            write_file("#{root}/app/controllers/concerns/response.rb", resp_template)

            # Update Routes
            unless lookup.has_key?(:"skip-routes")
                routes_template = get_file_str("#{this_dir}/../templates/routes.txt")
                routes_file = get_file_str("#{root}/config/routes.rb")
                routes_arr = routes_file.split("\n")
                last_end_line = last_end_index(routes_arr)

                new_routes = routes_arr.slice(0, last_end_line).join("\n") + "\n#{routes_template}\nend\n"
                write_file("#{root}/config/routes.rb", new_routes)
            end

            puts "Your project has been initialized."
        end

        def last_end_index arr
            arr.each_with_index.inject(0) do |acc, (e, i)|
                acc = i if /(end)/.match(e)
                acc
            end
        end

    end

end
