class String

    def underscore
        self.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    def camelcase
        self.split(/(?=[A-Z])|(_)/)
            .reject { |e| e == '_' }
            .map(&:capitalize)
            .join('')
    end

end

class MoreUtils
    class << self

        def versions lookup
            version = nil
            begin
              version = lookup[:version].to_i
            rescue
              version = 0
            end
            
            return version < 5 ? wrong_version_error : version
        end

        def wrong_version_error
            puts 'Must provide a version option'
            return false
        end

        def gem_version
            "0.4.0"
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

        def get_flags arr
            arr.select { |e| /--/.match(e) }
        end

        def get_args arr
            arr.reject { |e| /--/.match(e) }
        end

        def flag_lookup arr
            arr.each_with_object({}) do |e, acc|
                e = e.gsub('--', '')
                key, val = e.split('=')
                acc[key.to_sym] = val
                acc
            end
        end

    end
end
