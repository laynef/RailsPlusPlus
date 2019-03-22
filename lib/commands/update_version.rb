require_relative '../utils/strings.rb'


class UpdateVersionCommand < MoreUtils
    class << self

        def run *args

            # Add Controllers
            gc_template = get_file_str("#{this_dir}/../templates/global_controller.txt")
            write_file("#{root}/app/controllers/global_controller.rb", gc_template)

            gc_template = get_file_str("#{this_dir}/../templates/response.txt")
            write_file("#{root}/app/controllers/concerns/response.rb", gc_template)

            puts "Updated your code base for Rails Plus Plus version: #{gem_version}"
        end

    end
end
