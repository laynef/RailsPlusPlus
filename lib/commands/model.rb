require_relative '../utils/strings.rb'


class ModelCommand < MoreUtils
    class << self

        def run *args
            lookup = flag_lookup(args)
            arguments = get_args(args)

            if arguments.length < 2
                puts "Enter a valid model generation command."
                return 
            end

            model_name = arguments[0].camelcase
            others = arguments[1..-1]

            system("rails generate model #{model_name} #{others.join(' ')} --no-fixture")

            api_version_path = lookup[:"api-version"] || 'api/v1'

            system("mkdir -p #{root}/app/controllers/#{api_version_path}")
            controller_prefix = api_version_path.split('/').map { |e| e.downcase.capitalize }.join('::')
            controller_name = controller_prefix + '::' + model_name

            controller_temp =  get_file_str("#{this_dir}/../templates/controller.txt")
            controller_regex = '{{ CONTROLLER_NAME }}'
            controller_str = controller_temp.gsub(controller_regex, controller_name)
            write_file("#{root}/app/controllers/#{api_version_path}/#{model_name.underscore}_controller.rb", controller_str)

            if lookup.has_key?(:'with-test')
                routes_file = get_file_str("#{root}/config/routes.rb")
                routes_file_arr = routes_file.split("\n")
                last_namespace = ':' + api_version_path.split('/').pop
                regex = /#{last_namespace}/
                route_line_index = last_regex_index(routes_file_arr, regex) + 1
                starting_space = count_spaces(routes_file_arr[route_line_index - 1])
                add_space = get_space_str(starting_space + space_count(starting_space))
                new_routes = routes_file_arr.slice(0, route_line_index).join("\n") + "\n#{add_space}resources :#{model_name.underscore}" + routes_file_arr.slice(route_line_index, routes_file_arr.length).join("\n")
                write_file("#{root}/config/routes.rb", new_routes)
                system("ruby #{this_dir}/../railspp.rb mt /#{api_version_path}/#{model_name.underscore}")
            end

            puts "#{model_name} model, migration, and controller has been generated."
        end

        def last_regex_index arr, regex
            arr.each_with_index.inject(0) do |acc, (e, i)|
                acc = i if regex.match(e)
                acc
            end
        end

        def count_spaces line 
            _, spaces_at_beginning, spaces_at_end = /^( *).*?( *)$/.match(line).to_a.map(&:length)
            spaces_at_beginning
        end

        def space_count count
            2
        end

        def get_space_str num
            str = ''
            num.times { |e| str += ' ' }
            str
        end
    end
end
