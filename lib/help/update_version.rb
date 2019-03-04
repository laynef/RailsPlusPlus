require_relative '../utils/strings.rb'


class UpdateVersionHelpCommand < MoreUtils
    class << self

        def run *args
            puts "No Options available

Update your version of rails plus plus in your code base:
'railspp update_version'
"
        end

    end
end
