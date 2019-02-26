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

            system("rails generate model #{model_name} #{others.join(' ')}")

            api_version_path = lookup[:"api-version"] || 'api/v1'

            system("mkdir -p #{root}/app/controllers/#{api_version_path}")
            controller_prefix = api_version_path.split('/').map { |e| e.downcase.capitalize }.join('::')
            controller_name = controller_prefix + '::' + model_name

            controller_temp =  get_file_str("#{this_dir}/../templates/controller.txt")
            controller_regex = '{{ CONTROLLER_NAME }}'
            controller_str = controller_temp.gsub(controller_regex, controller_name)
            write_file("#{root}/app/controllers/#{api_version_path}/#{model_name.underscore}_controller.rb", controller_str)

            if lookup.has_key?(:"with-mini-test")
                system("mkdir -p #{root}/test/controllers/#{api_version_path}")
                mini_test_temp =  get_file_str("#{this_dir}/../templates/mini_test_controller.txt")
                test_regex = '{{ NAMESPACE }}'
                params_regex = '{{ PARAMS }}'
                snake_case_regex = '{{ SNAKE_CASE_NAMESPACE }}'
                snake_case_controller = controller_name.split('::').join('_').underscore
                params_str = "{ #{others.map { |e| "#{e}: " }} }"
                test_str = mini_test_temp.gsub(test_regex, controller_name)
                test_str = test_str.gsub(params_regex, controller_name)
                test_str = test_str.gsub(snake_case_regex, snake_case_controller)
                write_file("#{root}/test/controllers/#{api_version_path}/#{model_name.underscore}_controller_test.rb", test_str)
            end

            puts "#{model_name} model, migration, and controller has been generated."
        end

    end
end
