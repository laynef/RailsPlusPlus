require_relative '../utils/strings.rb'


class MakeTestHelpCommand < MoreUtils
    class << self

        def run *args
            lookup = flag_lookup(args)
            arguments = get_args(args)

        end

    end
end
