require_relative './commands/initialize.rb'
require_relative './commands/make_test.rb'
require_relative './commands/model.rb'
require_relative './help/documentation.rb'
require_relative './help/initialize.rb'
require_relative './help/make_test.rb'
require_relative './help/model.rb'
require_relative './utils/strings.rb'
require 'rack-cors'
require 'faker'


class RailsPlusPlus < MoreUtils
  class << self

    def error_string
      'ERROR: Must make railspp commands in the rails root directory'
    end

    def check_directory
      File.file?(root + '/bin/rails')
    end

    def run_command arguments
      is_help = arguments.select { |e| e == '--help' || e == '-h' }.length > 0
      command_name = arguments[0]
      passable_args = arguments[1..-1]
      lookup = is_help ? command_name_help_lookup : command_name_lookup
      command_exists = !command_name.nil? && !lookup[command_name.to_sym].nil?

      if command_exists
        command_class = lookup[command_name.to_sym]
        command_class.run(*passable_args)
      else
        DocumentationHelpCommand.run(descriptions.join("\n"))
      end
    end

    private

    def command_name_lookup
      {
        i: InitializeCommand,
        init: InitializeCommand,
        initialize: InitializeCommand,
        m: ModelCommand,
        model: ModelCommand,
        make_test: MakeTestCommand,
        mt: MakeTestCommand,
      }
    end

    def command_name_help_lookup
      {
        i: InitializeHelpCommand,
        init: InitializeHelpCommand,
        initialize: InitializeHelpCommand,
        m: ModelHelpCommand,
        model: ModelHelpCommand,
        make_test: MakeTestHelpCommand,
        mt: MakeTestHelpCommand,
      }
    end

    def descriptions
      [
        '- i => Initialize your project',
        '- init => Initialize your project',
        '- initialize => Initialize your project',
        '- m => Generate your CRUD model, controller, and migration',
        '- model => Generate your CRUD model, controller, and migration',
        '- make_test => Generate your resource unit test',
        '- mt => Generate your resource unit test'
      ]
    end

  end
end

