class ModelHelpCommand
    class << self

        def run
            puts "Options:
You have the abliity to enter an api-version through namespaces.
You can generate your controller in your nmespace directory.
By default the value is 'api/v1'

Enter your namespace directory-path from controllers directory without
a starting '/' in this option.

    --api-version=(namespace-directory-path-from-controllers-directory)

Example:

--api-version=api/v2

Same command as:
rails generate model <model-name> 

With your generated controller

Run to generate your model, migration, and controller:
'railspp model (model-name) (models-options) (your-api-version-flag)'
"
        end

    end
end
