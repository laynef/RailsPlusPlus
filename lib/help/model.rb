class ModelHelpCommand
    class << self

        def run
            puts "No Options available. 

Same command as:
rails generate model <model-name> 

With your generated controller

Run to generate your model, migration, and controller:
'railspp model <model-name> <your-arguments>'
"
        end

    end
end
