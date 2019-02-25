class DocumentationHelpCommand
    class << self

        def run descriptions
"#{ascii_art}
Rails Plus Plus Version: 0.0.1

Rails Plus Plus: Command Line Interface to make your life easier.
=> The Rails Plus Plus command is 'railspp'. To blast this project into the fifth dimension.
=> Use '--help' on any of the commands listed below for more details.

List of commands:
#{descriptions}
"
        end

        def ascii_art
""
        end

    end
end
