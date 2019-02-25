class ModelCommand
    class << self

        def run *args

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
  