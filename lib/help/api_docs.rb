require_relative '../utils/strings.rb'


class ApiDocsHelpCommand < MoreUtils
  class << self

    def run(*args)
      puts "No Options available

Update your version of rails plus plus in your code base:
'railspp api_docs'
"
    end

  end
end