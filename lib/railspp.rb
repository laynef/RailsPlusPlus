require_relative './commands/initialize.rb'
require_relative './commands/api_docs.rb'
require_relative './commands/model.rb'
require_relative './commands/make_test.rb'
require_relative './commands/update_version.rb'
require_relative './help/api_docs.rb'
require_relative './help/documentation.rb'
require_relative './help/initialize.rb'
require_relative './help/model.rb'
require_relative './help/make_test.rb'
require_relative './help/update_version.rb'
require_relative './utils/strings.rb'


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
        mt: MakeTestCommand,
        make_test: MakeTestCommand,
        uv: UpdateVersionCommand,
        update_version: UpdateVersionCommand,
        ad: ApiDocsCommand,
        api_docs: ApiDocsCommand,
      }
    end

    def command_name_help_lookup
      {
        i: InitializeHelpCommand,
        init: InitializeHelpCommand,
        initialize: InitializeHelpCommand,
        m: ModelHelpCommand,
        model: ModelHelpCommand,
        mt: MakeTestHelpCommand,
        make_test: MakeTestHelpCommand,
        uv: UpdateVersionHelpCommand,
        update_version: UpdateVersionHelpCommand,
        ad: ApiDocsHelpCommand,
        api_docs: ApiDocsHelpCommand,
      }
    end

    def descriptions
      [
        '- i => Initialize your project',
        '- init => Initialize your project',
        '- initialize => Initialize your project',
        '- m => Generate your CRUD model, controller, and migration',
        '- model => Generate your CRUD model, controller, and migration',
        '- mt => Generate a unit test in minitest',
        '- make_test => Generate a unit test in minitest',
        '- ad => Initialize your api documentation',
        '- api_docs => Initialize your api documentation',
        '- uv => Update your version of Rails Plus Plus in your code base',
        '- update_version => Update your version of Rails Plus Plus in your code base',
      ]
    end

  end
end

