require_relative '../utils/strings.rb'


class MakeTestHelpCommand < MoreUtils
    class << self

        def run
            puts "No Options available

With your generated your mini test

Route Path Example:
'/api/v1/user'

Run to generate a mini test for your controller:
'railspp make_test (route-path)'
"
        end

    end
end
