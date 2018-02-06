require 'yaml'

module CodePages
  class CodePage
    attr_reader :id, :name, :resource_file

    def initialize(id, name, resource_file)
      @id = id
      @name = name
      @resource_file = resource_file
    end

    def to_utf8(str)
      str
        .each_byte
        .map { |byte| unicode_mapping[byte] }
        .pack('U*')
    end

    def from_utf8(str)
      str
        .unpack('U*')
        .map { |code_point| code_page_mapping[code_point] }
        .pack('C*')
    end

    def unicode_mapping
      @unicode_mapping ||= YAML.load_file(resource_file)
    end

    def code_page_mapping
      @code_page_mapping ||= unicode_mapping.invert
    end
  end
end
