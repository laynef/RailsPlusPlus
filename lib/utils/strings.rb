class String

end

class MoreUtils
    class << self

        def gem_version
            "0.0.1"
        end

        def get_file_str path
            File.open(path, 'r:UTF-8', &:read)
        end
    
        def write_file path, str
            File.write(path, str)
        end
    
        def this_dir
            __dir__
        end
    
        def root
            Dir.pwd
        end

    end
end
