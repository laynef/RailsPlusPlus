class InitializeHelpCommand
    class << self

        def run *args
            puts "Options:

You have the availability to skip portions of the 
initialize command.

If you would like to skip the initial route nmespace use:

--skip-routes

Run to initialize your project:
'railspp initialize'
"
        end

    end
end

