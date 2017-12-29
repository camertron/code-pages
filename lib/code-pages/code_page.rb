require 'yaml'

module CodePages
  class CodePage
    attr_reader :id, :resource_file

    def initialize(id, resource_file)
      @id = id
      @resource_file = resource_file
    end

    def to_utf8(str)
      str.each_byte.map { |byte| unicode_mapping[byte] }.pack('U*')
    end

    def unicode_mapping
      @unicode_mapping ||= YAML.load_file(resource_file)
    end
  end
end
