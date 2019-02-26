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

            puts "#{model_name} model, migration, and controller has been generated."
        end

    end
end
