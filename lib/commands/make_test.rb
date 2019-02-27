require_relative '../utils/strings.rb'


class MakeTestCommand < MoreUtils
    class << self

        def run *args
            lookup = flag_lookup(args)
            arguments = get_args(args)

            namespace_regex = '{{ NAMESPACE }}'
            model_regex = '{{ MODEL }}'
            routes_regex = '{{ ROUTE }}'
            namespace_snakecase_regex = '{{ NAMESPACE_SNAKECASE }}'

            # api_route = arguments[0]
            api_route = '/api/v1/user'
            namespace_array = api_route.split('/')
            model = namespace_array.pop
            namespace_array = namespace_array.reject { |e| e == '' }
            namespace = namespace_array.map { |e| e.downcase.capitalize }.join('::')
            namespace_snake = (namespace_array.join('_') + '_' + model).underscore

            test_template = get_file_str("#{this_dir}/../templates/mini_test_controller.txt")
            test_template = test_template.gsub(namespace_regex, namespace)
            test_template = test_template.gsub(model_regex, model)
            test_template = test_template.gsub(namespace_snakecase_regex, namespace_snake)
            test_template = test_template.gsub(routes_regex, api_route)
            write_file("#{root}/test/controllers#{api_route}_controller_test.rb", test_template)

            puts "Genreated your unit for api route: #{api_route}"
        end

    end
end
