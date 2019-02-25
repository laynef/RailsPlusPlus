require_relative '../utils/strings.rb'

class DocumentationHelpCommand < MoreUtils
    class << self

        def run descriptions
            puts "#{ascii_art}
Rails Plus Plus Version: #{gem_version}

Rails Plus Plus: Command Line Interface to make your life easier.
=> The Rails Plus Plus command is 'railspp'. To blast this project into the fifth dimension.
=> Use '--help' on any of the commands listed below for more details.

List of commands:
#{descriptions}
"
        end

        def ascii_art
"______      _ __                 
| ___ \\    (_) |      _     _   
| |_/ /__ _ _| |___ _| |_ _| |_ 
|    // _` | | / __|_   _|_   _|
| |\\ \\ (_| | | \\__ \\ |_|   |_|  
\\_| \\_\\__,_|_|_|___/                       
"
        end

    end
end
